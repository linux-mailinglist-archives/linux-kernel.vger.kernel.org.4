Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6F6D9CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjDFQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbjDFP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:59:56 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F06A27A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:59:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7283F5C00FB;
        Thu,  6 Apr 2023 11:59:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Apr 2023 11:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680796791; x=
        1680883191; bh=trO8jc03FJLvTQr9TJ/mrkQxrmA3NZ7pQ+cjfH4ljHA=; b=D
        dqEV9U0jb0GbAcy+Z+YHa9vWqDcOdV11TU5V3txMnnIIP/5vEB/EV2TeqaYRqUp7
        O+do7wxJwzR7J/3JEqfHu4EgpTMFhEOC/lPN/RWakbh5xgkNK22zvCQ7TPe64fRP
        9IGy/0C+rB6l954EP+bkQg0WIzCWHx6GyPwQHu3jIRohFqwkpIx1Jc+Nz7IswKxu
        CL/oYYxIb4os9svlgXjpF4iKyF4f0kYxFuCoHqC2ahtMQe923nFOQBb3DojjpyjN
        oCX64nG1Gyo1gWIcUTr5y6wWe4wBqJoq6JAcaq4j44DqeMYf0f1HNN5ZcrPnoV4d
        tzTboTMYUMoD+DS56fbIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680796791; x=1680883191; bh=trO8jc03FJLvT
        Qr9TJ/mrkQxrmA3NZ7pQ+cjfH4ljHA=; b=pVWYKPCweySGyFodQ6stjV6Orskps
        S7oJXvI2shkOWIEovlHJFRiFkQfHb0YTEWY3C2pvDbKp55W17Zas4Jg40lv2Pe+u
        QOxUbsSeJMhOSG549C1WvdfU8INOnYKan6gTN/HzhhIKn7mRGHnqxCp5/IfyOk2x
        w4EsV4p49OqaDs6qeA9P+oj0A/mSJQSBrsE8KfSko3HetmPKDEz3aK9ImQ82WBKA
        nZxOofj9FwGWum+FeFiNdtHRPeEHSuNxdakoG5liGZUzlD+nY/0KarBj1Afo/PLd
        XiIm11qskilbFiB+NuPDlU2tDmfSGP808fBwBggLNSB3GIEKDD32aqhIQ==
X-ME-Sender: <xms:d-wuZOGYKRdPR4FbI4wBLuDKAm8j3exKvy9T1tef-ZE7RsJW4NNaZg>
    <xme:d-wuZPVZcpGEqAapEzOLb6WE1_46iwN6h887z22Zg2NoOLsj_nD1VZzlDMMJyHejC
    8Yz4CuDKJYIAiFS3Dg>
X-ME-Received: <xmr:d-wuZILDvgWryvRzbtLcNV4ftpHtlhS2gPs_MA1Cz2ybUprj1_8TDB6zUvjai6lk2Ya7_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffhedvveeuheeljedtkedtkeeiieekgedtveeu
    tdejkeevudffudfgveeggfduvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:d-wuZIF2mxK6csJbkXB-3A945w7EesREBPmn9cnIOex7jg2etjySRA>
    <xmx:d-wuZEUf2fFnY9JHWBwxEmRYym8tSQhcQmta4B-BbQ4a_Iqd8GJVyA>
    <xmx:d-wuZLPqDDZ5MOd7SMGtP98upclQctmwMR7OxTexonXs5V0Qyo_hSA>
    <xmx:d-wuZPaUeJMiAOaHvIwALv4LZxdCaqv8_faqo09_L9GQZXMZ5IA9Ig>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 11:59:50 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 311BB109B00; Thu,  6 Apr 2023 18:59:48 +0300 (+03)
Date:   Thu, 6 Apr 2023 18:59:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/mm/iommu/sva: Fix error code for LAM enabling
 failure due to SVA
Message-ID: <20230406155948.hlhb53xb3plq6sh5@box>
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
 <20230403111020.3136-2-kirill.shutemov@linux.intel.com>
 <24661bc4-cc95-5c1b-b88d-94d4ce335d0b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24661bc4-cc95-5c1b-b88d-94d4ce335d0b@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 08:31:40AM -0700, Dave Hansen wrote:
> On 4/3/23 04:10, Kirill A. Shutemov wrote:
> > Normally, LAM and SVA are mutually exclusive. LAM enabling will fail if
> > SVA is already in use.
> > 
> > Correct error code for the failure. EINTR is nonsensical there.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> 
> Hi Kirill,
> 
> These look fine. But in the future, Link:'s for Reported-by's would be
> very appreciated if the discussion happened in public.

Got it.

For this one it is:

Link: https://lore.kernel.org/all/CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
