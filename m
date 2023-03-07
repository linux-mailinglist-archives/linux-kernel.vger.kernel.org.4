Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FC6AD8EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCGIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCGIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:15:43 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77777497C9;
        Tue,  7 Mar 2023 00:15:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E45965C0561;
        Tue,  7 Mar 2023 03:15:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Mar 2023 03:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678176941; x=1678263341; bh=Hm
        07sqySuKUxzpvkQ23XmW4OObXTH92oKa0jToSXpUE=; b=q2l3SmAjXQ5dRNvILG
        6hpmumeQgAoEeBos/DKG40cWgVIyGUY3gaDcJDtqqaeU4Vk/NjNC6QIE5vRelGCF
        K1uiTYXLIRX9ouH0NXdlgB7AQ5sJUDNO0HdoNsa/ABkKCj0qBhPcpqHQm4v+tqYj
        BZ12mqDFKsBhqy3QugRQOQyvIlSmXZr6J4ZncHk916vaYTIaZjx3ZmeywPr+V+Ut
        pWRlilpGocKC5smsUEgXJjL3HaaXi8lUE1SguYF1M4Sf0QZ37Lgzafuxnvt66mC0
        nlHt1a5/eszYtKcsigHusYTzd1TTHtla5L2eIjGmyBJdlhUDo7RhVLEM2wsa7Ovn
        5vdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678176941; x=1678263341; bh=Hm07sqySuKUxz
        pvkQ23XmW4OObXTH92oKa0jToSXpUE=; b=CQgGcEgEdDThQR94w6svPShi6nXjh
        6WBCjguHQwoFr26M+wUCTVLQqQInNP0gmv1FjvTN4oukN8T7nx1glpMs1TfUqWAJ
        UI5x5ZC+LbuSDYd4jFOm47jSyyQchVaJjGwY3ZlQAe5yGg/5RgB/9RAl/+G4NVrT
        mvxTqEcIURSC3reb/cNVbAaAb90DeHRBWYoaFW6cggGVOlldjVHRrlCd4SqEMB51
        fdebxeCLJ06+VPIinSvsozPsErFFsJKIBrwVSlHaBnzZFgZ9zJtmFumFXz2Yax+/
        NNuLne7kGrxHZLirJRjVayO1pyEaPkpKjnAkJnhqU777Rz3UBIs+eJepg==
X-ME-Sender: <xms:rPIGZBKBG8lE_4Lz3LTSP_fYP-FWnbWp_xG66x3CPvhD2ph3q_egKQ>
    <xme:rPIGZNI8OjeVXXY6FXpZP76VWbXuFcOdgYDyca7OExXa88oZ9Rs5OXsqpJf0FDBMQ
    f4jV2E1bqRz3RB9NNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rPIGZJvpaPsHYSjtwABff8TpAv5GvhAAiTSp7LwLbxrqKSlySe-8MA>
    <xmx:rPIGZCYlVFcYIiS6P-TR0PjFqji0P6sbHdHUaenBjUXA6SR89iBLng>
    <xmx:rPIGZIa5fzfr_YVcF6NzbSAfKE1wgbJYLlY23FLv05yRbiP0D36sCQ>
    <xmx:rfIGZNNOky7F16JCzs7wu7utpCiHR7LS7QOrTB-0PmPzPBMNv1ZgaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 297A9B60086; Tue,  7 Mar 2023 03:15:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <69d943f7-fa47-48c3-8b38-f3de4ea08ec0@app.fastmail.com>
In-Reply-To: <1678175940-20872-1-git-send-email-yangtiezhu@loongson.cn>
References: <1678175940-20872-1-git-send-email-yangtiezhu@loongson.cn>
Date:   Tue, 07 Mar 2023 09:15:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 RESEND] checksyscalls: Ignore fstat to silence build warning on
 LoongArch
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023, at 08:59, Tiezhu Yang wrote:
> fstat is replaced by statx on the new architecture, so an exception
> is added to the checksyscalls script to silence the following build
> warning on LoongArch:
>
>   CALL    scripts/checksyscalls.sh
> <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
>
> Suggested-by: WANG Xuerui <kernel@xen0n.name>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
