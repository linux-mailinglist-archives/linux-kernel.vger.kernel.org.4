Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029973779D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFTWxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjFTWw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:52:56 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32491703;
        Tue, 20 Jun 2023 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687301566;
        bh=zs2PR8BnoBNeCG8m9yaBb0c55LdBttZyLue3jnCjvnE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hhLTYSLaQEJJCXbKmfhm2W7yZCBqjWGxOLPHfogIMLaiGGv/1HWr8raKXtQGFs44u
         a1XFq2fBt0husKXHQ3h02yuWf1lcQI9NwfvERQiUGeFmqn5nTQZy+rJe5BHf9Yn/jg
         qN5ruyXMrGGm8umyS6G1cZilpmn+anIyrO10oqaU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A543B12819DC;
        Tue, 20 Jun 2023 18:52:46 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id IfQ-VT9XKtPc; Tue, 20 Jun 2023 18:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687301564;
        bh=zs2PR8BnoBNeCG8m9yaBb0c55LdBttZyLue3jnCjvnE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=r3LnEOvh0IY2cCDJNP2XrVdZXinOFnWOgYKM/bn3fmW4jCk6H5t44RjS+KksZRnlZ
         zjD0dxc882ViaeFLh5v9SDjlOUWxzFOJMFVplCvHHXbQPXb0n0R4cfrLSpv1fAGDwG
         qoVbc/T2mD9qpIUqwik4dm22dqZCWLEZ59aLAieY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 563271281446;
        Tue, 20 Jun 2023 18:52:44 -0400 (EDT)
Message-ID: <1a631328115eaecbfebf8e435b9224bf2ff248af.camel@HansenPartnership.com>
Subject: Re: [Tech-board-discuss] [PATCH] Documentation: Linux Contribution
 Maturity Model and the wider community
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-doc@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 18:52:42 -0400
In-Reply-To: <7fef2bbb-4c5a-52b8-8e85-400a8fbb8786@linux-m68k.org>
References: <e78eef83a50a558aae765baafcf9c571788a02a5.camel@HansenPartnership.com>
         <7fef2bbb-4c5a-52b8-8e85-400a8fbb8786@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-20 at 13:50 +1000, Finn Thain wrote:
> On Mon, 19 Jun 2023, James Bottomley wrote:
> 
> > On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> > > The Linux Contribution Maturity Model methodology is notionally
> > > based on the Open source Maturity Model (OMM) which was in turn
> > > based on the Capability Maturity Model Integration (CMMI).
> > > 
> > > According to Petrinja et al., the goal of the OMM was to extend
> > > the  CMMI so as to be useful both for companies and for
> > > communities [1][2].   However, the Linux Contribution Maturity
> > > Model considers only companies and businesses.
> > 
> > That's not a correct characterization.  The model is designed to
> > measure and be useful to businesses, but it definitely considers
> > the community because it's progress is built around being more
> > useful to and working more effectively with the community.
> > 
> 
> You're right, the characterization I gave does exaggerate the bias. I
> shall moderate that if I resubmit the patch.
> 
> > > This patch addresses this bias as it could hinder collaboration
> > > with  not-for-profit organisations and individuals, which would
> > > be a loss to  any stakeholder.
> > 
> > I don't really think changing 'Businesses' to 'Organizations'
> > entirely addresses what you claim is the bias because individuals
> > would still be excluded from the term 'Organizations'.  I also
> > don't really think it matters.  Part of the reason this whole thing
> > doesn't matter is that sometimes people do know who a contributor
> > they work with works for, but most of the time they don't.
> 
> This is not just about patches, it's also about incentives and
> influence.

I mentioned contributor interaction, which covers influence.  I'm not
sure what you mean by incentives or how it is covered by changing
Businesses -> Organizations.

> 
> > If you really want this to be inclusive, you could change it to
> > 'other contributors' but I'm still not sure it's worth it.
> > 
> > > 
> > > Level 5 is amended to remove the invitation to exercise the same
> > > bias i.e. employees rewarded indirectly by other companies.
> > 
> > I also wouldn't remove the bit about seeking upstream feedback on
> > employees; I know from personal experience it happens a lot.
> > 
> 
> If it happens a lot already, why compel employers to seek it?

Because it's a sign of open source maturity on behalf of a company. 
Lots do it, but lots don't.  By putting it in the maturity model we
want to encourage it.

> It's worth noting that the model compels employers to seek "community
> member feedback" which is not the same as the "upstream feedback"
> that you describe.

It isn't?  How else does a community express itself except by its
agents which are ipso facto community members?  Not all community
members have identical opinions, but if you talk to several you'll get
a good sense of community feedback.

James

