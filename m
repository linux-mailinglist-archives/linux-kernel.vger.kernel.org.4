Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD06B7572
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCMLLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCMLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:11:18 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED655DEFA;
        Mon, 13 Mar 2023 04:11:04 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PZv912zwCz4BKKC;
        Mon, 13 Mar 2023 13:11:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678705861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n01MccDTHh22uo4xhDzHcV+/DWCHMADC+u6W1HFC/RE=;
        b=NHR5visfxTIvSgzvbyS4JsCO0iI3WLKhzoahDBJ6Ui/AShCeQQsCv5pbEZuETzSRBNajtI
        I06MyCK/yDEfuePEWl0n0cZ4v84yM7x9VVl7Njn4DLtkiERBTRzJAE1Rd7gm5W3ITJoeOm
        VnFd6la+6wZxi9os+GzFHEi/x+F7Y//Y6Fzap1pQyLpa9xvTF9JLPG4ZjDgDuSnh3lNmDD
        rclrztYT3QF+wyxCSQxJBXl73V20+77ntjW8Kchy/SlDEP+2UrXf0QOHh8FzNKTHk3W5pi
        PQ9w10t+5ecGV5u/584pOQZ0Y2SoAQyt2mxGMrRsoX6ia8LdTdh1Cb9O3G8FQw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678705861; a=rsa-sha256;
        cv=none;
        b=Gc1JNDPkBI77aBozqjDlIB8T3AojkfQA0dxrcbTYgtFnC/GjeHCEry6s2HZZFQElTxn4LU
        kQenmHE+ZoiPJxC2uXR3YOmbref5Vs8Yna/1HgJoP3HFug+Ns8AV/9VKVWJUSCvNeFJ049
        tAoExUYFHUNDXXdkSRTqwIlj5O6RLZHivLpwbf1Bfk2DuaBmCppeMXwMSx2V1r48pTqlan
        LObOezAX9WdjCf2NzvEMfuoBXwJx9mjrUM0mO+miMq06q35HlbYXw+ypT8491bk6Z/xzMA
        +oJl4iclYDOuR3L0gHFHZFfI012BHvxVQAE5sIyPfmktlhzIkUs902XV1lPitw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678705861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n01MccDTHh22uo4xhDzHcV+/DWCHMADC+u6W1HFC/RE=;
        b=UGi0i607bps/aSl6gXD/u0oEBzdv9th7Zo85r5apuPurSh0zwR1lkxpPSIIvXlfG93LFlE
        ZRK5qKk6RwcwvtFkBqXOA9hCFfR79AcVjD6Q6iKj3BoZjkhM5RcXiYQflw9C40XASQ3GM5
        CoXzk02qW3VqmD9KYBO5eSpXfmdslqkuNMiv+RWVi0K/Zn+lyOk0XTottfqtmdcTCCtdKT
        AmZBG98KhSnrRBAz8PoPf+zlj4YwR2HAKyT77+25fba9AYzb0xE5yTYFq9si6zY14RPk0Z
        j4cGXq6rmG/dYNZ0zo9QuhDL3LCWG/mxWzDE0fa9Kb20qJrVOVhAoRJ3TKijdA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 474A2634C91;
        Mon, 13 Mar 2023 13:10:03 +0200 (EET)
Date:   Mon, 13 Mar 2023 13:10:02 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Kang Chen <void0red@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2: check null return of kmalloc in
 format_ref_list_p and format_ref_list_b
Message-ID: <ZA8EivEAn7NCRH11@valkosipuli.retiisi.eu>
References: <20230226065011.2688452-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226065011.2688452-1-void0red@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kang,

On Sun, Feb 26, 2023 at 02:50:11PM +0800, Kang Chen wrote:
> kmalloc may fails, *out_str might be null and will cause
> illegal address access later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>

This seems to have been addressed by commit
be3ae7cf4326e95bb1d5413b63baabc26f4a1324 that's already in upstream.

-- 
Kind regards,

Sakari Ailus
