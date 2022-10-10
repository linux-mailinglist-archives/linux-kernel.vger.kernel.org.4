Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F05F9C50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiJJJ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiJJJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:57:40 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39B60685
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:57:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 0FCAB2B06732;
        Mon, 10 Oct 2022 05:57:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 05:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665395853; x=1665399453; bh=AmCAIAyh/t
        b4Tia73jc031lB07lXjb9ab6ibTSy0AQM=; b=oTXnu2D7K0I/sed2RJeUoRaeiZ
        2SXb4MZ7RpFMCv56QmuG9QyEugdUyQ67pID4QlLCVEtumMpLwiX6Zc6l6KzfRfZ/
        Gc4DHmMCn+T8f85d69yO73wmOQc+eph9pnVbaTCVJUQQQgP9/nt291IemR01VMS9
        6ob9s3mCSASOBGAH9Z9do4iSbXiQyO8vhMftKtAXGw4Gh7kCEAWsEW0RADtOGHRe
        foh2uYYPXiRrZa6f8S6ENCWiEY1YT6qb6Bx8leaH1H7IPXrlnFAheJFommaMy6T/
        ldEt+6BFrzKNlCdY3ZwJQjjg+oLSW9Y/ZTgJAvdDhNUdLpS6UGAHjBbxCumA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665395853; x=1665399453; bh=AmCAIAyh/tb4Tia73jc031lB07lX
        jb9ab6ibTSy0AQM=; b=KU50sjpD3UnjhIOGYhbxsL1mkLXgQpwL3B0SI71etnO/
        NQDWkvNXM2QsN3C2WQ5dB9g+lFdKRsUDOeenbve7l1mHjKn60P4ULuzfQtokWmXW
        j+bnid64ff58jn274Umv0q1GVQoHCXoiab4RJlWia4q565B9KqWajhWjIVtDXn4v
        S+fYg3Pl3GVB+dOY7amVngjEpvfSSAXd9yAyd8bjWIkHv2plDZg9GMfG3y4vUUA6
        /Yd+kcMNIzbat5jrRbWf+frkjdtWlf80/+qqYoDtxkMM26+p4X6/u8eK3QMizFuT
        nOR5Y1tutg4IXuWrd3dN+fKMkMbc/en6Gu9oNSfIOg==
X-ME-Sender: <xms:jOxDY6OlbqIQOJaya7aNvYdNgDlIZWLTCqzOPvwGRhlTUmB8zkyqwg>
    <xme:jOxDY48UJ-ZRVPCk1HiWgcykgiidECAHkffAXcTRHGY-h-I4N4CuU8TXSYy7YkqA9
    qTI119AVDGmJi-T_5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jOxDYxSTUAgSaKy2JzTOvjcu90YRSgyTeCWArZVh9jadzVC5lZ35MA>
    <xmx:jOxDY6sDxiGqQjZFYxJKbhx6cxN9W1NSWJuthja9XrCyt2-qtSX2UQ>
    <xmx:jOxDYyf2gjANeVMSrbgY53TYn2PdiMqQF5edkdZRYjPShzfIJFl_TA>
    <xmx:jexDYx7WTnOTcA9oEvRZTx_bxTyIUbudIb4r6lp5GreghEn-edpuq4ulaSk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C133CB60086; Mon, 10 Oct 2022 05:57:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <8ded6196-009e-4a85-b4f2-bea5d0b49ec4@app.fastmail.com>
In-Reply-To: <202210101659.LTN2etmy-lkp@intel.com>
References: <202210101659.LTN2etmy-lkp@intel.com>
Date:   Mon, 10 Oct 2022 11:57:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, "Mark Brown" <broonie@kernel.org>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>
Subject: Re: sound/soc/codecs/lochnagar-sc.c:247:34: warning: unused variable
 'lochnagar_of_match'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022, at 10:45 AM, kernel test robot wrote:
>
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> master
> head:   493ffd6605b2d3d4dc7008ab927dba319f36671f
> commit: 5b7f4e5de61ba8c44317718936864da29eeba62a ASoC: codecs: allow 
> compile testing without MFD drivers
>
>>> sound/soc/codecs/lochnagar-sc.c:247:34: warning: unused variable 'lochnagar_of_match' [-Wunused-const-variable]
>    static const struct of_device_id lochnagar_of_match[] = {

The 'of_match_ptr()' macro usage should be removed here, since
the array is defined unconditionally:

--- a/sound/soc/codecs/lochnagar-sc.c
+++ b/sound/soc/codecs/lochnagar-sc.c
@@ -253,7 +253,7 @@ MODULE_DEVICE_TABLE(of, lochnagar_of_match);
 static struct platform_driver lochnagar_sc_codec_driver = {
        .driver = {
                .name = "lochnagar-soundcard",
-               .of_match_table = of_match_ptr(lochnagar_of_match),
+               .of_match_table = lochnagar_of_match,
        },
 
        .probe = lochnagar_sc_probe,



    Arnd
