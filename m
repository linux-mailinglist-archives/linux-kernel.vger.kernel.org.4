Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29D66BD0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCPNZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCPNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:25:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AC0244A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:24:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a32so1680980ljq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678973084;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UzIvUMeHkBxSNjrNqEoM5ayZSGeqe3kADntSj6mQ6qs=;
        b=aSZSO0uNjdsFVZn3r/0SPXbiJbGxt9X+eTp/g0bmRaCYLSHmGQDaZgM/L2PrqSZufr
         YAH7WxDz3kCGCUViz/AwSuOfHPcs6GU5nq01+gtTy1et6WYt2EkNZZBSYf9Os+LIpWIV
         d6fQJKnVgsh8/AUxg9+cpoVQ9igR6LE4vSMrT7R9wMkKF1TQZM0eWZZkNL+S1Qh9ahiv
         p62qzakfJCbRNUKqXnHeO2OAF5zUJT9Jv7ngYrhKq7qZFi9a84B8nGclFMPsjEMrNRca
         aWWJxMvXVqq64PGDGCKfkR6obSnuKTCpQue0OLmW9nKiIu1PHjArJ3S5FJDZPSmYWchD
         uLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678973084;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzIvUMeHkBxSNjrNqEoM5ayZSGeqe3kADntSj6mQ6qs=;
        b=I+fUPOqlAV5q8lyEky8VPb+vRS+KB7zPCqoydRpJph/vrsGQHBNeGnDkjvuIIaPV7+
         kiLqNnr7FEG7fJ76w0yC1+5svTkVPeRZ+yIWKwoGP9kzoxQJflBd/UVws2tr524gyERd
         2qm4rAwxPd12RUxFNIrbKu1Bu8/U1AcD8gLMvPlOMs84BZMfbCauLcurhy4+aVFSrziL
         HlDQLidOikdJfMjoHNtqsJbNgpsZf2CcKpA/gn5oPHvgw1XNgoZIsHs/q/Ba2gJt7RLY
         Ez4CYvJfUUNK95fFyDV+Yr2LrXHiV/oW+LaKZEJ6o2sFhLuvxmo4lRHavuHKWDsuf984
         M9WA==
X-Gm-Message-State: AO0yUKW7qyrn0b5jE0AxyPco+HqfUipS0RUI81GPCJ9v1d169Kg9sUw5
        Ij77paX1MZgqJDLHG9tzXS4ZLSn/PCY19BE88TI=
X-Google-Smtp-Source: AK7set+/B0T9+OH7y+LI+moSAyh+d7T646csJD/VfoDWPKi7YK13n5EC4eWt29DYC93pXvtw+QD3salY0LvucXLX8MA=
X-Received: by 2002:a2e:8e29:0:b0:295:a64f:9d50 with SMTP id
 r9-20020a2e8e29000000b00295a64f9d50mr2065865ljk.5.1678973083937; Thu, 16 Mar
 2023 06:24:43 -0700 (PDT)
MIME-Version: 1.0
Sender: kathleenfatoudouglas@gmail.com
Received: by 2002:ab3:7a16:0:b0:21f:be21:74d1 with HTTP; Thu, 16 Mar 2023
 06:24:43 -0700 (PDT)
From:   Anson Brudenell <ansonbrudenell3@gmail.com>
Date:   Thu, 16 Mar 2023 13:24:43 +0000
X-Google-Sender-Auth: 7RBuzf154Bk41JroqLJShHCZQwo
Message-ID: <CAAY0GDn4OwPRev6EtNLvkZrG2nhCSV60DAE4er7pCZdDGhjuBg@mail.gmail.com>
Subject: Re: Hello Brudenell
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WW91IHJlY2VpdmUgbXkgbWVzc2FnZS4gQW5zb24gQnJ1ZGVuZWxsDQoNCten15nXkdec16og15DX
qiDXlNeU15XXk9ei15Qg16nXnNeZPyDXkNeg16HXldefINeR16jXldeT16DXnA0K
