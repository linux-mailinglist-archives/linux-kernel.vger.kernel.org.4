Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0A6D7639
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjDEIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjDEIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:04:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F35258;
        Wed,  5 Apr 2023 01:04:38 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id nc3so8377923qvb.1;
        Wed, 05 Apr 2023 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680681877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5PlaQL0CwR1homUmLCaXKeBaMRCzkIszzV6MDUmfG4=;
        b=YNPV6kOcrw8yHuwnYLE+ZH8fv/gPuymuZVnICGCeZbz/+Cy85jGtT3FrkaCy+2qe7n
         FeMVf5hYCb1UzyVbusTEAv1Qf5c2wborR1NlhnqvE+Xt6FNTgcTnMcW+ODGuBgLAgaJ6
         vtUlEs5J6ioKRVzrQ5M1VWXkHgBU65FXj5AnvXcAQsn6k+DqSM5+AGcI5YF8y3l1A3Sq
         zNNVwK1djHbmKfKT+FVlJKNF7FSXanDFg+eRqRYFYvQWtISQVsql6R4rKIYVpjCDWiv9
         71ZDqMchKYOV2fIcDmhJTeJcb08hH8z+2LEls2dy6bPhdfs0ctBlsq46lJkHSmiKYP8r
         oV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5PlaQL0CwR1homUmLCaXKeBaMRCzkIszzV6MDUmfG4=;
        b=BpkbFQwk2Nb71kfTKUEI6o1oLv1hs0hxVm+yehpWKso5yjoz2EM5XY1v3S2oaevB7i
         q0a2+fY/mtOC4jGnZINynonrfof2OzfZgUnFzGeGqA607cFFdNDZC9hmprJR2za13LHK
         MXuDFsIzspGXiwaI02DGK5+/5ewkCTtx+K0HLeAXpyhm7uMToZ87ukpNXSxh5Kengnay
         A3N/xVyJwk+49AMLSzaLofuw18odzCQ71jUv3kLrWf2DbIfUXPsKvmXOKKOkUecKIv52
         krx6uHOMgW8ykFlAHHS/l+Dl3KYYiXLUqzS0cu92lyG8zXpDZOFQ7VdaXdPEA3yJ39cW
         QozQ==
X-Gm-Message-State: AAQBX9fW1wQtpCU0bbgICyiif3KYUaRXgyLb5BKw6euQ881ZLKGVkHr7
        TbSn2kpySA8gRPXm43qsHUA=
X-Google-Smtp-Source: AKy350ZGNrcVWqCmJG7MDx3CCggJaOTbtdILZjJWRUgva6hOWEcG/qwscVEjJzWs+5IqLSiAfz0HVA==
X-Received: by 2002:a05:6214:2342:b0:5c0:51f0:eb45 with SMTP id hu2-20020a056214234200b005c051f0eb45mr7720103qvb.15.1680681877394;
        Wed, 05 Apr 2023 01:04:37 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f30-20020ad4559e000000b005e2fc1182besm3340730qvx.4.2023.04.05.01.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:04:36 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mazziesaccount@gmail.com
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, stwiss.opensource@diasemi.com,
        support.opensource@diasemi.com
Subject: Re: [PATCH v2 1/3] regulator: da9063: add voltage monitoring registers
Date:   Wed,  5 Apr 2023 10:04:22 +0200
Message-Id: <20230405080422.560239-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2652d7df-b208-b88a-026e-5821d3d745ef@gmail.com>
References: <2652d7df-b208-b88a-026e-5821d3d745ef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the feedback!

On Wed, 5 Apr 2023 at 09:29, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> Just a very minor thing - wouldn't this check be better as:
> if (regl->info->vmon.mask) ?
> We may have device(s) where 0 is a valid reg. However, mask 0 is
> probably not making sense - unless I misunderstand something?

This config is specific to the da9063. On this IC, register 0 is used for
PAGE_CON (control register). The registers relevant for voltage monitoring are
on 0x115-0x117. So IMHO this should be fine.
