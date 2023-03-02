Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97916A8572
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCBPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCBPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:38:56 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42271A969
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:38:55 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id cf14so18388371qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQqfbkai3G3Okc9zzdmukV52FaKGT5H5Wef3oNx2u6s=;
        b=BUGi1aJkMdwjEfIeIGan4dWvLkC4qfKXqtADX5Tt22O6n7mPXLBOWU0MVTEXiPru0p
         4P8T8Zw3Y6V8xdL81+SwYy3XiK4FGBfOnkS2uo4+GqvLpEcZvhZFhBwv5dc3lgkvOq1f
         udA7uUFqdFctM3EYG2m085yVB0YmV6xobNpmNIytnZ58bdUWvCMo3WK5lF10ObiViY3u
         PSqNbr4Td9ZVvPxsgk1AA6D8OH5X5+mJ3BmGL2VKajqv1ZlOgJY/T5ceXhfZXagoqI7d
         AVVPzA0XuTm3s7n8ZqnoZSPe0yoZjf/Rkn1im8hsCjyzPOp15DWVSuXcIunYd8Rw9Kff
         0kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQqfbkai3G3Okc9zzdmukV52FaKGT5H5Wef3oNx2u6s=;
        b=FeSp0vqDHhm/C+1LljwId/12Mg4uLMKmkcDHMTTZezrOCc7lP5Cxd+IKpcWmmgaUnr
         AZnCGgmCeokzkh2oLB/04rTC4PAzFXQKopc5KzkOwRFWZBD737vrAz8u+qPnurIv14zN
         96DGVn6vuAugHHfqpcSMbk99nWdyTX+gzXevD4BIohnl4gNKKwdmyj3GO1pbUQK+7cNX
         LxPTgWLT8v2ABPAwrDFW+fGtg+lZRl5jKsIJEuR46GerTJa+yJzUQSs2eP2jqpqhzeCV
         6waSA3GghMtLUIgemmW1OQJnPQA4VXnCcad3X1Y5wuJhuh/I/M5iXmsYq+zr7/FCibw4
         qCmQ==
X-Gm-Message-State: AO0yUKUsO/vZQ7F/exz3fkaya/0aQCJnU+/HF1vKbr+ILxBWdxnwsMw9
        wWkHBsorDIP3gkTqLSsujz/90nN6NGQ=
X-Google-Smtp-Source: AK7set+seFy/g+jKA63/YKQ23UhaHBJH1s6V/XDws/OVXmqjuVmUPZhj1HgIVDNmo605QewW4oo88g==
X-Received: by 2002:ac8:7dc2:0:b0:3b1:ca9c:6c38 with SMTP id c2-20020ac87dc2000000b003b1ca9c6c38mr18601011qte.51.1677771534870;
        Thu, 02 Mar 2023 07:38:54 -0800 (PST)
Received: from localhost ([45.61.188.240])
        by smtp.gmail.com with ESMTPSA id 15-20020ac856ef000000b003bfeb30c24dsm4689830qtu.39.2023.03.02.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 07:38:54 -0800 (PST)
From:   Jeff Pang <jeff.pang.chn@gmail.com>
To:     jeff.pang.chn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: amd/pm: mark symbols static where possible for smu11
Date:   Thu,  2 Mar 2023 23:38:53 +0800
Message-Id: <20230302153853.64818-1-jeff.pang.chn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302091614.62093-1-jeff.pang.chn@gmail.com>
References: <20230302091614.62093-1-jeff.pang.chn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

someone else had already submit...
https://lists.freedesktop.org/archives/amd-gfx/2023-March/090029.html
Thanks to Evan.
