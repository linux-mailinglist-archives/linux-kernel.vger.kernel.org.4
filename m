Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5918E738A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjFUPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjFUPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:54:25 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6616BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:54:23 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f9c0abc876so7005695e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362862; x=1689954862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow4u8rF5ZICwJ1i0HHUW2kF8oaOKifr2oHRIZZg2U0A=;
        b=dFwP77kP6q01u2pKpWKv+257194gpWwDfh3akoTUMzPGtn2c2kMlfxJtNgWSyX6OtH
         5zaAIptlha+TrEHccd4243t8nWIlTywLjBC5HaobPY34aLC8Wv06mX4fJDWpoYaJ72NY
         LfCLAHQ0xPkY67aFlBXd5X0gSPH19WIu7I+F+Rg91ROSvatzJJ0LHtE06gU9Wnzswy2c
         zCVnv1u9axDLETO9E5LgLYB/Z/KUeBgLe/bBzrmUqgAkZ9dh+jvAg/HiBgF6EZKytjac
         0cGRA9wtIExRd1jQ7ctbnL8fmd6gd5IpHqaZaR3z66d2Db5Q39jMWeoHUaKohe4k5iys
         dbDA==
X-Gm-Message-State: AC+VfDyvXTUgz7j67/zjBqiSUb6ozOgyrTdN9i6K59Ni9LtdSMaM4TIY
        /Bn+1MQtcVJrbpU+UaZNFyM9N51baBU=
X-Google-Smtp-Source: ACHHUZ7uLsAtdVMHG7W8iSaaDk1xk9SrgZdD5683IvhP+DIPJKSDV4PZNrNoZKY9ui7p+Q5hEfGHIA==
X-Received: by 2002:a7b:ce91:0:b0:3f9:bd9e:321c with SMTP id q17-20020a7bce91000000b003f9bd9e321cmr1656241wmj.31.1687362862229;
        Wed, 21 Jun 2023 08:54:22 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm5383739wmi.15.2023.06.21.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:54:21 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:54:17 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <ZJMdKUr98H8zPSAl@gmail.com>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621001327.qdyebewnx7r5aiy3@desk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:13:27PM -0700, Pawan Gupta wrote:
> On Fri, Jun 16, 2023 at 09:48:50AM -0700, Breno Leitao wrote:
> > There is no way to disable MDS, TAA, MMIO Stale data mitigation today at
> > compilation time. These mitigations are enabled even if
> > CONFIG_SPECULATION_MITIGATIONS is unset.
> > 
> > Create a new KCONFIG option for each mitigation under
> > CONFIG_SPECULATION_MITIGATIONS that allows these
> > mitigations to be disabled by default at compilation time.
> 
> I don't think all mitigations are still controllable at build-time e.g.
> spectre_v2 eIBRS mitigation will still be deployed irrespective of the
> config.

Right. This patchset only cares about MDS, TAA and MMIO. I am more than
happy to send a new patch to also disable spectre_v2 eIBRS.
