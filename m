Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE52070BA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjEVKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjEVKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:47:02 -0400
X-Greylist: delayed 6511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 03:46:59 PDT
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607EDC;
        Mon, 22 May 2023 03:46:59 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QPvJw6WRKzyWG;
        Mon, 22 May 2023 13:46:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1684752417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=458mfY2Qwo/3Pk10b/Ep3qoH4QSbeULEUhfNY9XD7Zk=;
        b=LOxmuxBAoOsYF1b+j222l9M8ypdlXbSnP1BD3JxnYO4NNbrKVCU236TfRqTBZEClAmzLVL
        gCa84FM95Dyt7OhE08xGw3n9zS9q9/E0TKttKo/6dWkxklr8xDylVa9tEygyLDp3vFAP8l
        8UJTISyY0PJrSzg1cp84dvRw280KLkA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1684752417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=458mfY2Qwo/3Pk10b/Ep3qoH4QSbeULEUhfNY9XD7Zk=;
        b=gNSPJIE5KD0YbLEotY8fYIccuT/fef30O0x4W6bBFwrfekuW1asd6XDGtdKFSWL6kLJjFF
        /AqdYTQ64LNfkefWwEW07hw6ut9aTTkyY1v979OGKIK1BxtOaMhHTR6vle2gIP38iTt6TV
        BfCOG+qKm8I1WkZCucWo3SAv2p51wm4=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1684752417; a=rsa-sha256; cv=none;
        b=JJ+M23dbg6sZvVZpD4MpMH9ltEIhOmslAXk7tpleYAM/hU8P/ULVMdr9+/1186MoF1FUnv
        CfFe8eps/UKutPHGDrNQD6wIAQfxHjtyKuPaFd/AqZ5X3KjXbCS5bVaZggy5yQXzROtnUL
        z6IttLcCt8+8zqGeuERo9aScWKxRn+M=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 5BFA7634C91;
        Mon, 22 May 2023 13:46:56 +0300 (EEST)
Date:   Mon, 22 May 2023 13:46:56 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 0/2] media: nxp: imx8-isi: Two build fixes
Message-ID: <ZGtIIDSfy7KJTn23@valkosipuli.retiisi.eu>
References: <20230428152156.22840-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428152156.22840-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 08:21:54AM -0700, Palmer Dabbelt wrote:
> These popped up last night as I was trying to merge in Linus' master.

Hi Palmer,

These have been already fixes in Linus's tree.

-- 
Sakari Ailus
