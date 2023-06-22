Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320BC73980A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFVHXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFVHXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:23:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F1172C;
        Thu, 22 Jun 2023 00:23:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 149655C0132;
        Thu, 22 Jun 2023 03:23:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 22 Jun 2023 03:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687418601; x=1687505001; bh=Al/ugtKM4zGeW
        WIaAMkQdgD0733cU/poF8FmUXKG1wM=; b=dHyK1KKK4X+f8zzsAqFX7SD63cCe2
        RnKjyvdMkUpzLnCdpBAo3+pETrEJntgIoBxOdJyjxYo3DE9BmEhkNnWtE1SAU3xq
        16qt4glsM7bcBkURkpL3+LCEyCwNf8kgQhjjOEi7KeyiWgDVeUzxa9EtvHusno6k
        42ggSi5Y8zI2DU2UpN7G6pRv3aGoNQfbw2zgVazkjQ2/ogqU/9tabDeCA5O1umx7
        aGHDJ32jOO27litdrozEolso2fzrhGpmMDhhJQgeyx8a0xRRgKfPPYZk+62+uZ42
        JmoKUBA4vN8YvLWHf4yRSd0UuL/ldjpdl9BjxCIaKiN3k4rIxrI5Q6fmw==
X-ME-Sender: <xms:6PaTZBCdS47oNc9jmL1BZlBi4Q4jOmuV2mgjzXbH2lkVXVjxnbRFsA>
    <xme:6PaTZPhbBHiZQjxFXautuNmWC4deIEjWFy7PfG8GCRXTyEvJ9eIdWwboJqkVlcQPi
    NDe99cQP6W7JtMScdk>
X-ME-Received: <xmr:6PaTZMlQfNQ9mMeHu8KkCHmV7Zw5W98m6CCbxoG-FWClFvCyAThCIxemElmKP5cWh2DyuystwbeWMdXD4A_qpfBH1o0zonWlqdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:6PaTZLxnsjV2EvyYtIGBpJpVL7nirlQRKAZZqM3W1BbBLfjSZvRS5w>
    <xmx:6PaTZGTXvAvvcPHEdhNdKODlKktwA_uRdz33Ds4hU3Zpp9GsHcFOvQ>
    <xmx:6PaTZOYpAnJlshSckggmGgArNupVkIs66AcsUwgNfekapyYbWgAeHg>
    <xmx:6faTZDIMJgZM5x-STKCNkEeOX2uhiW-NpN5Zax7MMyI1wL-bXR-LNw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 03:23:19 -0400 (EDT)
Date:   Thu, 22 Jun 2023 17:24:03 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <2023062245-engraver-antsy-005c@gregkh>
Message-ID: <5243a27c-afcc-3b67-7481-5e4fb5620f67@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu> <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org> <2023062144-hefty-why-305d@gregkh> <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org> <2023062245-engraver-antsy-005c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023, Greg Kroah-Hartman wrote:

> 
> > If there was consensus, it might be feasible to give a formula for 
> > "recognized usage" which could be quantified. From there we could 
> > create a kind of heat map to show which commits, maintainers, 
> > processes, models, modules etc. were the most "useful" within some 
> > time interval.
> 
> Determining code use is difficult given that we are not going to add 
> tracking to the kernel source for obvious reasons, so this is a 
> non-starter, as you know.
> 

It never crossed my mind that the kernel might "phone home". Counting 
execution events (privately) doesn't work either because it seems 
hopelessly skewed towards fast processors, clusters and fast paths.
Or am I missing something?
