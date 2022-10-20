Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82674605D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJTKjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJTKjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:39:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B81A810;
        Thu, 20 Oct 2022 03:39:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EBB6B5C00BB;
        Thu, 20 Oct 2022 06:39:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Oct 2022 06:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666262375; x=1666348775; bh=S1ftnTpYuQcReY/G3NfEdbNnp8Vp
        rTKoBjhbqWtaoKc=; b=iCe/Rvu6bFpLhdRiFLseQTjmRSppYh8mgDp5RDe8ipFd
        9uLniu4/r9mtcPD8lv275zKIgdR4yFWywgF0Zz2+3flDko2akg1azH+jf+SpnVaW
        WpwU+II1aXF1qcVWfsA9NNgpt8XZyYwrAdQsMDeoY5yCFXQNgDCYI30CWDCwaRNN
        jn7CcOKp26xwFy0HI9DNuWRTFoR6RpAD0r150+ViWcFUeYnrWWy69INJp19aixBC
        wWa9nP2b5yG4OR+VO11o9IfO0nWNj+vzyx3Gez/VN8kav1c/NmZmH9W11bbuTdCY
        NxWfoW9I/qYTDcpBhEvYs4PrKVxgxhwORef1aTT1cg==
X-ME-Sender: <xms:ZiVRYxamPMkznv1v4gD35Qh5Ob_8B_HMeffFsiEP1oo41XivTGmeKw>
    <xme:ZiVRY4aXSKTAiK6kMzIZW9ROlThi0biQ1d5pr3gTNuP6HdTRGI54ZcYt8dgiIydAE
    _0Sy0bRKS_t02A>
X-ME-Received: <xmr:ZiVRYz9A8wUI1GDguEybJYJTB5N5-Wb0wCzOABbO9gJzglDjesDBoOEjZ05G3HBlQ8Hf38WU0OaRG823w2pImYxwAIQskw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:ZiVRY_pgQjUJJ4EH5bbpEHHGoLgWIs6htf-8T7GagcTsRodooLpFsw>
    <xmx:ZiVRY8qqH7972EK5u_TwKWYQOTJ1PVLSVc_C16SA9I7TttkE81abow>
    <xmx:ZiVRY1TQC_P-976Dik7Lx5a4M8wQxPNGCDTFmNObfd4as8DgDiog1Q>
    <xmx:ZyVRY3WT-F5C0aQSEOnOAAYgsJWL6QE0GlmD2jeO8bQ5S6ZF7fjAMA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Oct 2022 06:39:33 -0400 (EDT)
Date:   Thu, 20 Oct 2022 13:39:29 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v5 01/33] thermal/of: Rework the thermal device tree
 initialization
Message-ID: <Y1ElYWjfP48kTuzS@shredder>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-2-daniel.lezcano@linexp.org>
 <Y05/8JUU+3kLCZvb@shredder>
 <6650b077-1900-a6e6-755e-a84282e5fd13@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6650b077-1900-a6e6-755e-a84282e5fd13@linexp.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:53:50PM +0200, Daniel Lezcano wrote:
> Thanks for reporting the issue. If you can submit it, that would be great

Sent:
https://lore.kernel.org/linux-pm/20221020103658.802457-1-idosch@nvidia.com/
