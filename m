Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F573B9E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjFWOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjFWOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:20:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA261296D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:19:50 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-666ec28a20dso306443b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687529989; x=1690121989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=35x5qxpF2qYzGzCpux1ZzZA29nJCgxRSAHhMlpTtq74=;
        b=c7/Mv2GzBTpMxlDln0Sehv1yTcEaixA7RDWInHiPZ8qzW5GwvkY/zKAM7l7Bc5vDa8
         hDiFsq15Wz2zFUFoWtMfbXwsDd+vrOCwF/cIATp2OnTxIWzNoiK1jlSLbZVmHoOJ/7vi
         OtBiuJJHOg6JoG8ZxlgkpXlZBpIiJhY/YJGFV2qXDPrJLU+IWCPtRpy57oHrGEEDOcKn
         xd3GkNzPA2glBPTifd2TCXN5VbnQHPhVgK1nErqSMqmhAtT4wyvlGXk/rUXCRzL4NpKi
         YKy3w1gtkYRYg6lV+4yPvCa1l/AcBUdWnT/SSIYObqH/VnQIpYYLGhOFLWHg/Y23A5QZ
         APtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529989; x=1690121989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35x5qxpF2qYzGzCpux1ZzZA29nJCgxRSAHhMlpTtq74=;
        b=Kn1NJ2FUXYgpOV5rQFA1Gk4zGdMBM6U6Bp4P2Mza9//7k30Nu3J1D76wAyNlQp4ZwQ
         O4Iak1UNmYpVY8s79uFe4+OG4VnraNVBEyMj7kNwScdgYaw/H/512SZ4nSUsfgoGpJ18
         R7W9R5am4riHJAnF+RqogWgn8WPHA1hCzfCmPXQhFUUS8AYmid3f3K3H+jqvD1dys+my
         VlOfPCh52QL745zwkhMFt+shKzxxGeArQS3z2Vkcb8hPfpfx5ilP0dlnluLuM8MaSugL
         t/215j1joAudvP5SeSbKgkIL7imBNBWMJsvhEwLlrFZb2gXYCfB23Q56AQtGRBBHrvwX
         GU9Q==
X-Gm-Message-State: AC+VfDxEYLojnj+Tu9sKi/36LyFHxxHCgpMVs7eL5DLiVEnxLm6w3OqT
        FbdDJqTWI+Ay+r6BTtaE8hm1yqtVaQ4=
X-Google-Smtp-Source: ACHHUZ63ia2UvaYfKaS8EqRcM930UL0opAkoHqHzypa37S+4ovmakcGgORyiJsCL5P1ICG+FKohhXfPKvgE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:811:b0:668:6887:18d with SMTP id
 m17-20020a056a00081100b006686887018dmr5332115pfk.6.1687529989678; Fri, 23 Jun
 2023 07:19:49 -0700 (PDT)
Date:   Fri, 23 Jun 2023 07:19:48 -0700
In-Reply-To: <6c5d1e74-0f6d-7c9d-c4e7-a42342ca60aa@amd.com>
Mime-Version: 1.0
References: <20230615063757.3039121-1-aik@amd.com> <a209f165-b9ae-a0b3-743c-9711f5123855@amd.com>
 <6c5d1e74-0f6d-7c9d-c4e7-a42342ca60aa@amd.com>
Message-ID: <ZJWqBO6mPTWyMgMj@google.com>
Subject: Re: [PATCH kernel 0/9 v6] KVM: SEV: Enable AMD SEV-ES DebugSwap
From:   Sean Christopherson <seanjc@google.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
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

On Fri, Jun 23, 2023, Alexey Kardashevskiy wrote:
> Sean, do you want me to repost with "v6" in all patches or this will do?

No need on my end.
