Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7662E9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiKQXqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbiKQXpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:45:53 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959C13E8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:45:19 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a15so4757544ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCuoQEbE7mjNCTWbIqtUQJL43XUQexy5VEO15NSlLn8=;
        b=qKHXjyYwj7zGEBWhi4DZxS1EH6QYc9ibBE239VeeNKgi5ANg8H2DAfl7vsDU8aDSew
         +bkbzuapnEB0XmVEOt/UkknzTdJ1/CktINSCSxOnHSKOd7VMD1lyomJcICmVr8GjCieY
         pt9YqPJ/0Or8MLCMORIU3ZAANrRwkIOvGM0uDsG6ozHCxpeS8BFuiI+GAd+lb+6ODjIK
         Iay9NlqSOcy5ISEpXnM7/rIcR9EVu5lHB2UOVn+Zikv5IDGUMnIlgALdRnNUCxbEs1lw
         t9oykz5bVvuY1EwHFJCqAaS/Ok6zb+Mv7H0lxKW4kIJMh2Yynn9Mks/jFaU2uFTNDuVo
         nemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCuoQEbE7mjNCTWbIqtUQJL43XUQexy5VEO15NSlLn8=;
        b=wfiWynpm0ZzZtqSVxoFaeLYMl4FXvZ/jmn1Wwko0fMgjTZ0hUnuY4JKK0e7B8bLBu6
         Uaocbkvj4ZBOalIL9qy8M5lCqWvlxtb3YXsN4u5vO9SY+yiriMVNOqbrFbTDbsussepI
         CpII9mqR+Ck7kmdnDXgarKQYC7YAH4HkhoT4bf9Zt6JAeqgp0DOpiGl0QUf0LwP8xBAt
         HVwFg8qDpLavKhsdogv1MCm7Gi2HqKm/rZcMY5RGtbeKPAENXyyyr88RQ5zb3b6/VrYr
         MVXaVEftE3YdcJTtz2xJOsTlbCtzCePow2bXuhjL0gDYpGj9nqe39SAvKWh+F/V89JkE
         foxA==
X-Gm-Message-State: ANoB5pltQ6S7jk/tc81iCPo/6t+OGfMJCascCoCTYlne8HF2nH0+S1Bo
        BaTolkkHBkTk/AIV9gvKzTyMOroJK44d1ZCc9PZ/Qw==
X-Google-Smtp-Source: AA0mqf4R+X0Ap/7NNtin7hrl/SOKdX5eIBg9DxT8xtR8pzTdGDdIVdNFWBC5HGRZJumh7O7zPhwjp0rMnHV9kk+V3i4=
X-Received: by 2002:a05:651c:98c:b0:277:6f7e:bfeb with SMTP id
 b12-20020a05651c098c00b002776f7ebfebmr1859569ljq.274.1668728717305; Thu, 17
 Nov 2022 15:45:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1667110240.git.isaku.yamahata@intel.com>
 <fb337a67e17715977e46523d1344cb2a7f46a37a.1667110240.git.isaku.yamahata@intel.com>
 <CAAhR5DFGvGQmf95hrGcK0uvawvFrzdCisnEtvLV8k8pM3FRV_w@mail.gmail.com> <20221117174826.GE2350331@ls.amr.corp.intel.com>
In-Reply-To: <20221117174826.GE2350331@ls.amr.corp.intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Thu, 17 Nov 2022 15:45:05 -0800
Message-ID: <CAAhR5DHEQdeprxNcvmXwn32yYdF5yuW4Nn5NuUYKW3Zj3xVd-g@mail.gmail.com>
Subject: Re: [PATCH v10 016/108] KVM: TDX: create/destroy VM structure
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 9:48 AM Isaku Yamahata <isaku.yamahata@gmail.com> wrote:
>
> On Mon, Nov 14, 2022 at 04:06:10PM -0800,
> Sagi Shahar <sagis@google.com> wrote:
>
> > > +int tdx_vm_init(struct kvm *kvm)
> > > +{
> > > +       struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> > > +       cpumask_var_t packages;
> > > +       int ret, i;
> > > +       u64 err;
> > > +
> > > +       ret = tdx_keyid_alloc();
> >
> > Can we skip the hkid allocation at such an early stage?
> > This makes intra-host migration more complicated as the hkid of the
> > destination VM is already allocated before we have a chance to migrate
> > the state from the source VM.
> >
> > I remember you had an internal version that already did that in
> > https://github.com/intel/tdx/blob/552dd80c48f67ca01bcdd10667e0c11efd375177/arch/x86/kvm/vmx/tdx.c#L508
>
> With the patch of "KVM: TDX: initialize VM with TDX specific parameters",
> the allocation code is split out into its own code with KVM_TDX_INIT_VM.
> I think that's what you want.

Right, I missed that. Thanks.

> --
> Isaku Yamahata <isaku.yamahata@gmail.com>
