Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306B7156B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjE3H2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjE3H15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:27:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA191B1;
        Tue, 30 May 2023 00:27:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D6525C00CE;
        Tue, 30 May 2023 03:27:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 May 2023 03:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685431658; x=1685518058; bh=uT
        5fhSrzmN7LJiave+NreiIlpJyvDnfSBX3PmNo78sc=; b=aKvzA+obNriRaOofBu
        TXW1a8gkCCkQ8NwHakS0v1AMWWv55ODu+v3/ScV3fyEy6Zy1ghCfDs/NQunUs/5W
        uSNAHilD7HhBLevVWXWt81fJgl+2Y/VMwmsRFE/gA3fAh3TTJSRGDhgZ7D2B9qYk
        JrS6TD50Rn6Cu+rWbghAdwBVFESQ1D1lDIby8+b5UNGeKybgYl4A+di4kT+qGeXc
        Y+9ifKbLOCZwpFP5cwNodHcANfp4bpouRQHKQIx0MQWIvmz0y/o4J2Yz1bpKdKrc
        1A8E+7Rnv+MOyyUArLROeco1ldDjrDtFOEI0zP5QCslVLeTxUWokTDSboXKnlEex
        t2Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685431658; x=1685518058; bh=uT5fhSrzmN7LJ
        iave+NreiIlpJyvDnfSBX3PmNo78sc=; b=bhOGrH8M79dpOdMqfaALKDzcTFzca
        KGnuqHRq1/TfXlxgDU5QL1ikvv4x2apOV0MqMVohBAOO+QCVPwFiNSd30vW5MnPk
        cij3V6TDGGJmyX9WHSrKC2N0hmbhiwPm9R+n1O9KYUVqTgTIAPZS/ogntMTt4Ya+
        jW2WabOWazuk7L9dZcQsx+Y1fcaisIyfop5Evi301SbvE3VdQrw67f9Nae3k12hM
        eWwjoomvgIPNKZrkDmmcsKvWeaEArOzC0txQTzAfKD9XhVqUAUS7J72pzdZ24wCx
        Gj77otpXuf8DVaiLzCuO1yfWJR1KFnfB0TxGaQumSQh7pyDzm4rYTByCQ==
X-ME-Sender: <xms:aaV1ZLFI3ZFsYh1P4gizLuDL4iKYx1MePgsXZe24UUIuL8Qzfi7hxg>
    <xme:aaV1ZIUVqbNkagqUMRRfRpibq4bVkSXcJmW1TOhaky_lyJtXJf75-Qx0k_dJPWXl0
    IngPPfwxnDxQw>
X-ME-Received: <xmr:aaV1ZNL_T4xvpKQ4jBw4cPx8Gdu2Q_wQGlCMA9pmc8p-Ni1oQiBdt-cWvBDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:aaV1ZJEEYtT-1eCbubGjFzm-ter6J1U7_yY7_tWAYzXBaQdFYqtiHg>
    <xmx:aaV1ZBX8xa2ELvbKGrsUoVsUJM3YtEXQz9ClgwlidXIdlcH68UfLQw>
    <xmx:aaV1ZEPPCfhxywIRSkaQvR0swdIbYOpyTRmmicB60buwS96mIZ6u4g>
    <xmx:aqV1ZDI8Yr-38jSlcAyOh2ZrQTK1NLMXdgekzKmIrGSGo2wnROQamw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 03:27:37 -0400 (EDT)
Date:   Tue, 30 May 2023 08:27:35 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Roger Quadros <rogerq@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the usb tree
Message-ID: <2023053050-patrol-item-1844@gregkh>
References: <20230530081611.20239925@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530081611.20239925@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:16:11AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   b4a4be847184 ("USB: fix up merge of 6.4-rc4 into usb-next")
> 
> is missing a Signed-off-by from its author.

Known issue, it was part of a thread as to how to fix up the merge and I
wanted to give the original author credit for it.

thanks,

greg k-h
