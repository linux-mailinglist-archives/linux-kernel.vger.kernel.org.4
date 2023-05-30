Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE64716A96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjE3ROW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjE3ROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:14:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58E7F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:14:17 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d24df4852so3108093b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685466857; x=1688058857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oW5kBn+PdJEe6rnXOx+ck1CwnlYyJC8NqkWMcNa5q8w=;
        b=5tqIC4aQWleru/7zEQ0O/WXJ4FaBYf8tAGYm6xgyYMK7b5MfPQD9AYDQ4YYAtrWSov
         sBHidJlws2X4SVko9faCr5yMOkwlEig9tMKy1cR+PrS6TJ//Uby+sck61oO29XO31jl1
         OxwY51SC8xVggRqjPel2Md8LNUuwnqlXJ8x5DG0An4gTYsKEmprDK736L5gwekv/MiWL
         VD0mRxnXpuF+S0DWCgL590UkgyZj3C69nzVCIaiB7+es2moWAfLtqrydqaEhdQyvJw7+
         IA23MdOc3WAECAZjKkoJe1yglPb6B+6MjV4nKmKwToSLcfLOlPTZBOqJf64uEpk0NQsl
         i6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466857; x=1688058857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oW5kBn+PdJEe6rnXOx+ck1CwnlYyJC8NqkWMcNa5q8w=;
        b=VIl2Pq2npubloYQaDoErs6MD7uRgG5l6Et/Jq0DyM4pO90dJZw/9hn8tABpXSGDt11
         hFAwfqynRdH8jtrzqeU2wZ/LE0JkYGZLzt3oENIXem9/z25yX/dPwsVs3PQx5RppkLV5
         N4VGy9Qa5AMdxw1cNQpmaqpK/lFm25TyEbmEp94LrW2DloHG9DMXRnSwwXgSMk6qJvCS
         JNfpNTFoZGGSHhb+JfZqUCLDAuQBiKIzsi0vu1nRuYUFAZ1WI6d+hYPlLEk+ltuZtHQX
         oWSYOGnVmzU381K6DEUw0U1MxBMFD+5119vsJcD6JWKlgr7z7yUt839Dgr0kJGTPbSOL
         IodQ==
X-Gm-Message-State: AC+VfDxU15AR+1dYFJyhHnidoeDpnJknswKldZsqs87Y6y4nwQtAZlKG
        txlGlSs9ZghO2BtBnFll7T10OlTACLM=
X-Google-Smtp-Source: ACHHUZ7Yj3FRLJmuyE2r93i9n0+xfvuQ5ZojKX+qIj+lPi2L12IcMOFH/kvwC3UzWxnLDX34U4WpmBgLQac=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a0e:b0:643:53b6:d86d with SMTP id
 p14-20020a056a000a0e00b0064353b6d86dmr1072552pfh.4.1685466857070; Tue, 30 May
 2023 10:14:17 -0700 (PDT)
Date:   Tue, 30 May 2023 10:14:15 -0700
In-Reply-To: <20230530215036.000066d9.zhi.wang.linux@gmail.com>
Mime-Version: 1.0
References: <cover.1685333727.git.isaku.yamahata@intel.com>
 <e628e2d235d9b6c00b9bd5d81bb69136b77d13c4.1685333727.git.isaku.yamahata@intel.com>
 <20230530215036.000066d9.zhi.wang.linux@gmail.com>
Message-ID: <ZHYu5yvtw7oMDUAP@google.com>
Subject: Re: [PATCH v14 004/113] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
From:   Sean Christopherson <seanjc@google.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>, chen.bo@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023, Zhi Wang wrote:
> On Sun, 28 May 2023 21:18:46 -0700 isaku.yamahata@intel.com wrote:
> > +	/* tdx_enable() in tdx_module_setup() requires cpus lock. */
> > +	cpus_read_lock();
> > +	on_each_cpu(vmx_tdx_on, &err, true);	/* TDX requires vmxon. */
> > +	r = atomic_read(&err);
> > +	if (!r)
> > +		r = tdx_module_setup();
> > +	on_each_cpu(vmx_off, NULL, true);
> 
> Out of curiosity, why VMX has to be turned off after tdx_module_setup()?

KVM has historically enabled VMX if and only if KVM has active VMs.  Whether or
not it still makes sense to do dynamic enabling is debatable, but that's a
discussion for another day.
