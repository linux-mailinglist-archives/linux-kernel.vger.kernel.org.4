Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14C6707222
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjEQT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjEQT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:27:02 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D74DC4E;
        Wed, 17 May 2023 12:26:22 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QM34W2J3tz49Q4J;
        Wed, 17 May 2023 22:26:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1684351579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YiOntKiq1t2aKqRxB/vNZKyQYA7kVVSMg4c0ahwgfE=;
        b=lP3edUuKvfOT3j9P9WCTsbYy1hDSxAjcOOSl3Zr7R/lFUnMA6BLPAIxu6el1oKDOPstOc1
        qYjxrMy9I6VBxm1TMubJxf75qXJRqAnwTje1Ut+EbnReFqg/ISbNDzCScGxC67dxZLck+K
        UWkaSMD4rXkwghAT24c8+Imnxg1waGSOaX/uJm7664u/GgDTgLGyox98LmrKOLUbZRme7O
        ETBYVcuYvgBkdvXfqd92Og2Cbb1YrCvYdEdbce+xfko9nzAnj5FbhPdBS9rZMaP+i9eXbF
        AjXz3TwyPKyIG5ejJub+c70LgYOe0/vlGgnK0yOqpBtRVPtVq5bfs6BlOKntrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1684351579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YiOntKiq1t2aKqRxB/vNZKyQYA7kVVSMg4c0ahwgfE=;
        b=uUn3WgrAZKxXYSfoJCCdHrj8DjGF6VzQmeuUS/+P7tzcAqmLfhrXKpBnen5GXF+M+pfPBf
        x3bCM0vBvbITCwoImVGrROwTN13Q0pn8/F1Tk3pO+Vkr1YKojIvXMshc/Sb+jXIpoGPePb
        arWBHCug7SSL3ycavtNVNXJat9Ql0/804VpsUB1BG5ZjhwjjPk7tZFxR96yGktyNayPHwN
        +JXVlNET+JGwxKDH3gbszf6Ai3zZc5rGSfpLJt1eJ18XrVEYfgG5Qnbx0z04I6RoU3VOMR
        8btiyMJR8qCljQPQcAERZkKx4Fg5r5Mp6i928IDfmNenVXat04AX36yC6yIBvg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1684351579; a=rsa-sha256;
        cv=none;
        b=hhovqfl84Yjvt+r8jS2uB88oxqxrMkh2YoN+3gMkCiBbir35b8VLX/0B+GRrsIf/3B40az
        BLHiqxvZJvCijLqVVdqu9TDC2o90jm2wmAVjYrZ8vqgTdN4N7WL/RO3qHul6nC2OI08MxQ
        OLteKGQ6wWH3rB9UrSN9SZvqtM3ahOQ1UTXN69IP5bdKw1wQ5lwQZzYTa1VqMq9px/LTA/
        oTXyRSTElOcv1FgXcEBGKhW3WnWbY90Xz8lfP0gU52HPtPS90fjbKcFQ25we02HqVDalzJ
        hmgjPi37jXvgedwPuV3SW80nPOjxC0ScJqXst7cy92tefAEDhQUWQt5qtnKC5A==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id E3F55634C94;
        Wed, 17 May 2023 22:26:17 +0300 (EEST)
Date:   Wed, 17 May 2023 22:26:17 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Message-ID: <ZGUqWZoxXRGGJ9Kv@valkosipuli.retiisi.eu>
References: <20230130131003.668888-1-arnd@kernel.org>
 <ZGUbDFssUwXKTiDt@valkosipuli.retiisi.eu>
 <ZGUnBfqBLWkD7ZgD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUnBfqBLWkD7ZgD@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, May 17, 2023 at 12:12:05PM -0700, Dmitry Torokhov wrote:
> On Wed, May 17, 2023 at 09:21:00PM +0300, Sakari Ailus wrote:
> > Hi Arnd,
> > 
> > On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The gpio usage in the function is fairly straightforward,
> > > but the normal gpiod_get() interface cannot be used here
> > > since the gpio is referenced by a child node of the device.
> > > 
> > > Using devm_fwnode_gpiod_get_index() is the best alternative
> > > here.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I've picked
> > <URL:https://patchwork.linuxtv.org/project/linux-media/patch/20230130131003.668888-1-arnd@kernel.org/>
> > instead. I hope that's fine. Also cc Dmitry.
> 
> What do you mean "instead"? This is the exact patch that started this
> thread, and it is broken (uses wrong name of the GPIO and wrong polarity).
> 
> I'd much rather you picked up
> https://lore.kernel.org/all/Y92VLGLQJZ%2FUDRx1@google.com/
> 
> Thanks.

Ah, the URL in my e-mail was wrong. I have
<URL:https://patchwork.linuxtv.org/project/linux-media/patch/Y92VLGLQJZ/UDRx1@google.com/>,
i.e. the same patch.

-- 
Regards,

Sakari Ailus
