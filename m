Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6F7077CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjERCGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjERCGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:06:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AB30C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:06:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5343c3daff0so980347a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684375565; x=1686967565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A6n7TPl3Bf8PshfqYMRFRlRyw953NrmDFfTNUP/bbQ=;
        b=QAc7usRIMsfTVODanK4D9s7wXoA5fw37B+ks+7mYoByTtuJEThS2hz9lBesIyc6cHG
         J7INqP09ttUF2Tw0vU1qkR4NDuxU09KLYAs04snDwN3OiqsApFfFIQsrEnR7cRv79CXY
         Z9vqpL1r/DSwvRWl3ONlJltGK3u9ZuS0+YIUh2gjrOBbOBfJthGqmQJR1jK4dA/gQ9qS
         iMm6ijqKoAwD60AtAZdw8EL8bhU4MYU8Rcoup5Gk7khpM6s50mUejGmi/DCYlezrkDeq
         a7UJZ+cZ7q0BpwgIUzcns5XBmcWivrDkxr10t7pLwVoPD7LNM3hJEQRVkpkN9dN/4/I/
         d1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684375565; x=1686967565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A6n7TPl3Bf8PshfqYMRFRlRyw953NrmDFfTNUP/bbQ=;
        b=HMiU13tTsaDWM65USOfsI1CH7O+yr12PLx4HDpoOOx0sufcY28wJ25+8nAchkTi7n/
         f/8fncG6da8ZIB7QEY5bGqPE/1vctxS5P1YWV/eLsyy+lIqOaxxC5KxIVgBaEj8S5wml
         xjpWLrr2/tEpurR4V70CRMpQdTb2ecR99KNJTtrB3FOCfNKQKTeZo5LxVW3uzlg9j+j+
         DhLg0B0k+WAHZvf39Q7Z99k+b3VYNambd8uG7l1pCuvHFis9338JOsVdr3NvMyyZ/Ny5
         ToQQoxuPY9AIWkN30h0kXT7CbLIy0iDX9La/wbkK+iup3rPA4/dtKNxsw4tR8iIpk6RN
         o7Rg==
X-Gm-Message-State: AC+VfDyaGEsJIzwffCZRu6AzUdffCRDgPLHeSLMtVP9IcnQrULjqtyAO
        ll7e4lIeIUOLaOP5RSgsmqQhy7uBq3vQAX42rBBHMA==
X-Google-Smtp-Source: ACHHUZ5+/xwE+l6usLwj6P1JHWzG5auA3q5JTxDnDA4ufgOuxaZgFDdN0+91BvUCU7lOuLiQ8eWjdhfb+k/PCoJSn1I=
X-Received: by 2002:a17:90a:1b0c:b0:253:2a56:3831 with SMTP id
 q12-20020a17090a1b0c00b002532a563831mr920985pjq.34.1684375565424; Wed, 17 May
 2023 19:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com> <CAMC_AXUkiHvBaWQm8fnAbgbxe59iF9UM59=yBoa3LcuLGQ=E3A@mail.gmail.com>
 <71A3F44C-B684-4946-AF11-3DB98E3AC641@vmware.com>
In-Reply-To: <71A3F44C-B684-4946-AF11-3DB98E3AC641@vmware.com>
From:   Jon Pan-Doh <pandoh@google.com>
Date:   Wed, 17 May 2023 19:05:54 -0700
Message-ID: <CAMC_AXUWDGy4u-WYYaiBCMZYKMxpzAvrZZORpUNZGpVr8GOr6Q@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To:     Nadav Amit <namit@vmware.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:58=E2=80=AFPM Nadav Amit <namit@vmware.com> wrot=
e:
> IOW: If the patch was still not applied by Joerg, please send v2 with:
>
> Cc: <stable@vger.kernel.org <mailto:stable@vger.kernel.org>> # 5.15.x
>
> In the commit log.
>

Thanks for the clarification/guidance. I've resent the patch for
review with added tags (Acked-by, Reviewed-by). Will re-read the patch
submission doc and try to avoid formatting issues in the future.
