Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C42729831
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFIL3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjFIL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:28:50 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4388B2722
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:28:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a5229df1f2so293994fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686310125; x=1688902125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+xlmvh6V5XUTOvaVdo2oTM812lLj1/E/Gtn582Obak=;
        b=uTs0VD/ITW7mLUURZ5Ak/QYqWcuuDnloinfJm3WFEXFYd3//u2zGnKOP6Ts/OZZvYI
         8vpIl1qtvPyUlt/+7r6OBL4/WprFUavnChMrZ185PWXpYSub7nSxc0QBgTjmlQGJ0Xaa
         01CdDKIGtMzpD27tl5dRiXvrrj79EKn2rmtTxgwCqjf/dpyqZjYCim9yIb0EyltJl2gZ
         PtxALFR4gCZFmziUVp4YY3BaH35EaFo8y3Xnk0cl/gIneGoik4TxFgimCzHbnAf54J1Q
         3c78ZDeJrV3zbswcbZeoYEFViUC+4V0jj5VoAZgou183e2shSkU3CqXC0Iq/vL8JIKbJ
         ofCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310125; x=1688902125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+xlmvh6V5XUTOvaVdo2oTM812lLj1/E/Gtn582Obak=;
        b=kpxAxxg70dBDmr94TOECzF2QJFtYYj9mtJVvsgqUf9KLvC9CnS8khWRfYbhJi4LIMb
         TuRTHB0NPef8WFOdu36aFf2aZtM3Ab9btBsW70npoJa1ITVbXv069tDe+vabe5WQ2ghU
         2geokp6fXRLesJraxp0cEYDmj1PmFPywo/1pyN6pWk/w29c5QmmB9fomJoH9wVReEQCu
         eaEr/ehxGGbgEjVrRYmv3InVwa3PcCF2PF4P8Idj3hyg6k0F2UvsJ4H01uzTsDJ9vBef
         qVlvO+CfrKO52dSU9RbAg50SAYVmUZLlok/qWlh/wGWlPTzSbfX9TPlAuEMXZPQ6pDFN
         9Rjw==
X-Gm-Message-State: AC+VfDzCogyTXxjqH4mHk3k8voOx0Z1vLprcgNlOngXIRi6XxmZC45B7
        KTSazGgXxFuBCf4kd+8q63SkXdUWrIFF1EjO2LJTJw==
X-Google-Smtp-Source: ACHHUZ5bvJWQ2B+G0u8EMiVWzaEFYIgGCw5RRiYPOkFWx/IaFZ885mQfPKSIdWEuuVd3xOp55Qqn1oA9kXRygQ2mMjs=
X-Received: by 2002:a05:6870:e14b:b0:19d:6f68:c3f with SMTP id
 z11-20020a056870e14b00b0019d6f680c3fmr958102oaa.33.1686310125565; Fri, 09 Jun
 2023 04:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230609071441.451464-1-victorshihgli@gmail.com>
 <20230609071441.451464-4-victorshihgli@gmail.com> <CAK00qKDkZ1wbxO+iyryrWv2KeXoZ6DMMrip215A2rds494hkGQ@mail.gmail.com>
In-Reply-To: <CAK00qKDkZ1wbxO+iyryrWv2KeXoZ6DMMrip215A2rds494hkGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 13:28:09 +0200
Message-ID: <CAPDyKFoe8jjTseeqS8532jgjMj28A80WW4U7YdStVgxtOqcq1g@mail.gmail.com>
Subject: Re: [PATCH V6 3/4] mmc: sdhci: Add VDD2 definition for power control register
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023 at 09:40, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
>       This patch has been acked by Adrian in patch v5, but I forgot to
> add in this patch version, sorry.

Thanks for letting me know, I have added Adrian's ack.

[...]

Kind regards
Uffe
