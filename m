Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F47070A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjEQSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEQSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:21:08 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B34693D9;
        Wed, 17 May 2023 11:21:03 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QM1d935d4z49Q47;
        Wed, 17 May 2023 21:21:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1684347661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQDStvIbW7UGWuPy2yJ4GFYZJS+LxAH2lk+n1n4DGtU=;
        b=QJ4bDUPke+hqm25eN0peiCWpEhHv2l+qMs2EV15uHEP/l10jL1Cl95vXxLVlMFUmDkvguw
        CXvBU60+kfZQECPxVVJSD+htmudhrz+oPoePIVYVA5BxFowd0Z9TQc4w8l9pVBiDLk4d3t
        ARf/NlPdQXiDNCGDygM/cbGQoZr6Vl8XM25H6I5vP1Td25+gKhvc0ORO3vuW4laNS2q2JE
        0v7Uuf+UhYPplc4BoElXYoGQosC1nNgz4NqMeLNrEsWuk1ngFM9IE6bbVjqcOHd2Q/C4Be
        9PATwkJkhSVZQGzbd19bBs1SOjDSsPm53dcrLXlP6vZFtdfJjHLNLJdjVfMUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1684347661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQDStvIbW7UGWuPy2yJ4GFYZJS+LxAH2lk+n1n4DGtU=;
        b=jqc2Kre3ntvqCmwH/e4vZt8H6sihFv9jff8xDCQfjulSqijtFf+b0DYTEc1fC8Rm4LbhxV
        498gntV3EgVnRQv5FjDwFhYW70ukbTDndFGREGLcxc4uBSdQ+v3jb2Fm99BMMn9V2dFH8s
        wweS1o2YfTvxV9hZIVATzjwAh4BxC/MAqqeZLDLvnTpr1r5FxiAxQ0Q7Je3THyR7WklMm+
        NLUbtsToT9rzYeVqYHquUY8DB2DNIn2azmyRkVw2kbyrFNp6irBZ5OKF0IUVViD1Nj9NzP
        A7Ecl7X8h31kvXRNr5fbr9hH5aLlSM87+yAofSVxIS2GnS1xL7ieIdrndJCtug==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1684347661; a=rsa-sha256;
        cv=none;
        b=AM1Ph2iur9qQRcG2eTc3eKOw9eY/7nF0CHrhsofRZDg5Y/20018SJk4mtAZcuHgOkuMzWE
        LB+tSLn2fWcQanEu1ffy2/OZAIqZXw/hdlQ0abbC8ZLksObmxTQtUyoE044lTHH9HiQhVx
        pxRMYkxsus/7C8lOGxRMoCPbJrjU8yTrsLEUVOiRhFAZWQfC/QcX9nQX0Si8mjsXN8ibHi
        jn8EU99YexCcubRc2vRWltxWWGYQU6ebag3cxfLTBotVLGIE08xhRN19oPv2eO1SvqAjts
        E5j0FYKci46IYUphqHcHHUr8yNO/cgJMh3d3azWgtKY22mNQF5aYLxZEP2oz8w==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id DE522634C94;
        Wed, 17 May 2023 21:21:00 +0300 (EEST)
Date:   Wed, 17 May 2023 21:21:00 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Message-ID: <ZGUbDFssUwXKTiDt@valkosipuli.retiisi.eu>
References: <20230130131003.668888-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130131003.668888-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The gpio usage in the function is fairly straightforward,
> but the normal gpiod_get() interface cannot be used here
> since the gpio is referenced by a child node of the device.
> 
> Using devm_fwnode_gpiod_get_index() is the best alternative
> here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've picked
<URL:https://patchwork.linuxtv.org/project/linux-media/patch/20230130131003.668888-1-arnd@kernel.org/>
instead. I hope that's fine. Also cc Dmitry.

-- 
Kind regards,

Sakari Ailus
