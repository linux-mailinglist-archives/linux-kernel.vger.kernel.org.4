Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821A6F56C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjECLBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjECLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:01:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48159E8;
        Wed,  3 May 2023 04:00:59 -0700 (PDT)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B25156600010;
        Wed,  3 May 2023 12:00:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683111657;
        bh=YgZoFypi9uBzyCleV28/+qccnmAQ9nqEaGbJaWVfyOI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oG7sXoN3W0Ip2e6rvOzM+wj6NYpQu709wQqRJnIFuQ6W+VyeaPUpjk/rRiG4L70xE
         4bhH14TnwyLVojgsFxLSIKFcK2QeHTa8GLMcE08xoefgIdSqjTnVdZQe+24n1NOILk
         cE1cjxXis+yFH65uk3fma9e9bOI6uFwxd/0zf2iloldTSBUgo3gV5Q1+dJzw5B60TX
         DUUKQ8g6XUXesoo5SDIAH2rAPlfxE+aDEPHOzADhqVkfHmsaaeBHW9riV476rNJYdg
         gJvgCNQ6CAw+fKtydNgfggARwcxWiRf4E0Er4wSz1RJjI1wLmrehefWaJulgXqYeyQ
         LlqPOZW1bvQ2g==
Message-ID: <56777298b3883fc2b105af52be80cf5f0cf14be0.camel@collabora.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Asahi Lina <lina@asahilina.net>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Antoni Boucher <bouanto@zoho.com>
Date:   Wed, 03 May 2023 08:00:40 -0300
In-Reply-To: <CANiq72m8cOWrO21PhUFcBap2j7ooKtAKdkOU9u8y-xGj_8fvoA@mail.gmail.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
         <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
         <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
         <20230426003210.GA31260@pendragon.ideasonboard.com>
         <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
         <20230426163512.GE18120@pendragon.ideasonboard.com>
         <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
         <20230426172539.GD2326@pendragon.ideasonboard.com>
         <9cf10a4d7a9eec237f5d18f79f6ae4bd031489bb.camel@collabora.com>
         <fe2dc70b-915c-ca2b-be81-a8ee66cf41cd@asahilina.net>
         <CANiq72m8cOWrO21PhUFcBap2j7ooKtAKdkOU9u8y-xGj_8fvoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lina, all,

I disagree that we need to wait for anything as a precondition for
writing the things Nicolas listed. The reason being that he listed out
some very self-contained codebases. These would not depend on the
kernel crate either for the most part (or at all, even, but going from
memory here..).

Note that the codec library in particular would rarely be touched after
it's written, as the algorithms in there are more or less "set in
stone" by the codec specs.

Maintaining these until they can be merged would be essentially free,
unless I am missing something?


-- Daniel

