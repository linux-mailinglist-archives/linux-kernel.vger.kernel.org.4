Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1B6C8955
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCXXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:36:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCFD536
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:36:07 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id m9-20020a056a00164900b0062300619e03so1659351pfc.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679700967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzD6dvewUhBNbui2HQuAy2o+vZGdl9ePlxoAR6ib/9w=;
        b=Q+pLF4cI7TqbBRgJQrqjz/nHaYu/kAlRlCtQ+1M5RdvHRFGrYnrfayiE7id9WzQymk
         pJE5ifKOQ+ExThs2jkMcWYP2dYivx5haQFx2mZlvHn+6TXsmVog2gVNzItwDg/NxoFGC
         kRvzCCO4MtagWEMfYAJ+6BrY/tlib9ya7ePnkvW/FGm7VhTqD04iM6VgMbidfXvaQKxE
         qi9S6nB8UPqBl3S/Pod/CNqXUic58cWlrn2z4FIfvd4JwDkhl9VJ3SH8oc8wHnaZAabv
         n9EF0UIL+biI2ipakbQ4YRkHghDonTFXcANnwT1xw9tpyiUj5WPlszGrB7zRpXS2CvtW
         NmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzD6dvewUhBNbui2HQuAy2o+vZGdl9ePlxoAR6ib/9w=;
        b=gclHv+cK9ghe0hiwuNPmbFPjN92q2rrK8GQypd32WvumoPWCNMVvvKJXiHnKjHlg8t
         RK8bzbGoHGN+XU3CQ9+6aMOMIRbb5DSza9hm46lNCnwxep6ueq9ix4c5/Vg5hYY5m/dH
         JF6v4JSwvnEoGBy1ThhCJoKJTysay8vArzWufhc0cl1yrm97e9V/ChRiP3BmxbDAo9w3
         HYlR6LeL5xuJFDneiI3SlJuaRJA4RbzvBy40/cSomS0UO7UScpNYZ7g/KjaSCzfSZW38
         jjEtLZbipQwEjvgRhPcLVrlc5U6iim54ov8/k3xl+cLPiVBmmoP4jM4zUYmUXq/lHtOT
         BbQA==
X-Gm-Message-State: AAQBX9fgx42BkOwA2RN3C/+Z9ubib3GyfqQGPOBAsGEQ6YqiVKGUmHli
        X9bkME3B/k3O54q6h3ZlzIDZeNu2vBA=
X-Google-Smtp-Source: AKy350YVBNOjjf+YX+5dkelN2BJWsr6boD7sAFGS/e0SbB44Ze2RR3ifnGzlHxlDn3qrW0JHEI32abPGKuU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da8e:b0:1a1:d366:b0b2 with SMTP id
 j14-20020a170902da8e00b001a1d366b0b2mr1509662plx.11.1679700967504; Fri, 24
 Mar 2023 16:36:07 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:35:45 -0700
In-Reply-To: <20230223052851.1054799-1-jun.miao@intel.com>
Mime-Version: 1.0
References: <20230223052851.1054799-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167969120469.2754732.14170657866913653110.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: Fix comments that refer to the non-existent install_new_memslots()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        Jun Miao <jun.miao@intel.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 13:28:51 +0800, Jun Miao wrote:
> The function of install_new_memslots() was replaced by kvm_swap_active_memslots().
> In order to avoid confusion, fix the comments that refer the non-existent name of
> install_new_memslots which always be ignored.
> 
> 

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Fix comments that refer to the non-existent install_new_memslots()
      https://github.com/kvm-x86/linux/commit/b0d237087c67

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
