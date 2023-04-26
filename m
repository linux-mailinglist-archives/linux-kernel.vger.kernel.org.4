Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828996EFC88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbjDZVdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjDZVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:33:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E6E76
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:33:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b4e5fdad0so8525949b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682544788; x=1685136788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6gblr+rFHKZD7TQERahHneNEtjZ/bNSKQPsJJcCZzo=;
        b=64Yxcr1gv5G1ETQLzD3H47rDdo9llnuvTFEaz75CzsReyyURjw7U8DWGnhmfXVvgtZ
         YyjiJSDUQj2A/nCNiitga4A5xU3qn7GA8HHODEzZFqstJ6xPwdWcKfVPsA/8yP6Gai8v
         pqcDFk3HITVbGtpz6z6qskA9c4AfU1GVXBltqvK+7jsS8ezrnFSS9gYo/v+NwdF1wU8q
         6U+Mkl74emXIw3FxE0fq6KRi66kPzgnHmDMcnbf6+jP8x37zNl+zx4xo8JHU/F2bf/vX
         1pzG/Na/2k6qt2JrHeWhVVSdK2MdhHAKZnc/Tm6KiWNw9es1T3MVQDxRUmKKfvKG8PfG
         yl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544788; x=1685136788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6gblr+rFHKZD7TQERahHneNEtjZ/bNSKQPsJJcCZzo=;
        b=B/yoK1z9z8NdIeDbvcYyvjBsqx8VAspQALhkh7202QIuG2ZKc7i+wAsgulzGflifaE
         0MZph+mKE1k+JOyv3NZ13ewAIEcykZSn3yR4OJSnU0m2RN4wE72X8APgyz7b4yf4/Ec5
         UZZ7S1zddpay6fzDUi6jRgWofoGjKx/h79QYQyfagxLH2PY7vG+JgfwDHAcaLI4QIban
         /db1Y1eEmfNJ6KvEcllk+YH5TVYVKqL0MsVxizMwp9RxL2Y8GP1Ft37+FuWefJ221ZEA
         Ybmee3I/lZwX15icd6r/owuNl6jyAaTIJraM8WaxN2jUVtyYiUjhqIqaaJJvaba+uEXk
         gfbA==
X-Gm-Message-State: AAQBX9cv7yI5td+Y2QR7Dk6tomwXzOiv2ECa3pt4O+o2oRpd+9QWFjtJ
        vqyyaPfpa8xlRcPFU0qERkvx6sM2T4I=
X-Google-Smtp-Source: AKy350Ywg746UTmjxVc3lRngXV/2GRWirJY3Wo6T7fLxvcZc5uWOilbZIUGF50vH2Wq5XgJ7IPSdZv2Jrbc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:134b:b0:63d:5dcd:bc06 with SMTP id
 k11-20020a056a00134b00b0063d5dcdbc06mr8678577pfu.5.1682544788341; Wed, 26 Apr
 2023 14:33:08 -0700 (PDT)
Date:   Wed, 26 Apr 2023 14:33:06 -0700
In-Reply-To: <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com>
Mime-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com> <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com> <ZEmBULXp24oMxaUH@google.com> <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com>
Message-ID: <ZEmYR0fWl05lGW0d@google.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023, Carlos Bilbao wrote:
> On 4/26/23 2:53 PM, Sean Christopherson wrote:
> > On Wed, Apr 26, 2023, Carlos Bilbao wrote:
> >> On 4/26/23 10:51 AM, Sean Christopherson wrote:
> >>> This document is named confidential-computing.rst, not tdx-and-snp.rst.  Not
> >>> explicitly mentioning SEV doesn't magically warp reality to make descriptions like
> >>> this one from security/secrets/coco.rst disappear:
> >>>
> >>>   Introduction                                                                    
> >>>   ============                                                                    
> >>>                                                                                 
> >>>   Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
> >>>   Virtualization) allows guest owners to inject secrets into the VMs              
> >>>   memory without the host/hypervisor being able to read them.
> >>>
> >>> My complaint about this document being too Intel/AMD centric isn't that it doesn't
> >>> mention other implementations, it's that the doc describes CoCo purely from the
> >>> narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
> >>> release and not an objective overview of CoCo.
> >>
> >> Be specific about the parts of the document that you feel are too
> >> AMD/Intel centric, and we will correct them.
> > 
> > The whole thing?  There aren't specific parts that are too SNP/TDX centric, the
> > entire tone and approach of the document is wrong.  As I responded to Dave, I
> > would feel differently if the document were named tdx-and-snp-threat-model.rst,
> > but this patch proposes a generic confidential-computing.rst and presents the
> > SNP+TDX confidential VM use case as if it's the *only* confidential computing use
> > case.
> 
> What part of us describing the current Linux kernel threat model or
> defining basic concepts of confidential computing is SNP/TDX centric?
> 
> IMHO, simply stating that "the whole thing" is wrong and that you don't
> like the "tone", is not making a good enough case for us to change
> anything, including the name of the document.

I honestly don't know how to respond since you are either unable or unwilling to
see the problems with naming a document "confidential computing" and then talking
only about one very, very specific flavor of confidential computing as if that is
the only flavor of confidential computing.

So if you want to push this doc as is, please add my

Nacked-by: Sean Christopherson <seanjc@google.com>
