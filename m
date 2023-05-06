Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7247C6F924C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjEFNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:49:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E49273AA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 06:49:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38e3228d120so1223430b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683380993; x=1685972993;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=ouNrBeEfMa5mkUXVTx8bjTuVoVWs8CmnuvbvFU8SG27Kow/1MVj6Ppoc0tszkUngkJ
         s1AO/rp3ekmO0QQoeMeftcH9PtCP1SvDaCBEX7FKXJrmiJKnAvyCdG1h+MQctPPEoF8X
         sDP6cv72Bga3KLgKeb8iBQaoRwNqeEGAdzxV+JxDUqycDcC2CzqgcFkYVRWBDqzH0mb9
         HdGVfna1ZzJPO0I6ML6pRXJ2jsV+wF4SXNhTDivDnGasYDZf4IvrJVWKTUA11X5tyJZy
         TiFJuBDNl8Oj4N/jQpqW9Eq2L7cHPZ9KPQrbRtsCLPk6ZEzIr+HCBf8bAzJOPQzxUXlT
         zatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683380993; x=1685972993;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=DaYhA1qBpVlXhlSjHhTTH+k9C9sBizQDa+8PsYJmVVFW5eDZsPoWEM9xMjfNQgQRJJ
         8cI/d5MUFTohIomadeqZwqhp0MW8dIq/vjXXq0af3BrhK8Z8R9l3HBEEMcmQzvYK/rRR
         LwJ44truFUCWXgzp/H8Ze+xFy4Hxvx7mkoLI/aObs8V3i6/sCdgqEgQn1oVmep4HiUz2
         tP5t5957I4y1gV8lCX1QI++hEal9xF5O3/IqJ0RHZ3RXrLUMeU5KMUtLyrdAodd6buzu
         e+5zLVc/0082b1/Lf2ev73kl0+v/ypLjmO+V4Cm+bRzuREobYahky8bEYJmG/3/6xF9F
         ndvA==
X-Gm-Message-State: AC+VfDwihY6Ttee1L6lA8yPFHLa7uj97GknQGzazObID+tBuLEmpl66e
        jpImJ/ih4JpXUjmm8Bppyz2mqxOJlF2iIR2PqQ==
X-Google-Smtp-Source: ACHHUZ7pXwvqTa3nUJfVA3lHClRjJQm3DCfxi+fU81yi5mszyWG7dAADu0owqPbAyDBR3MsXctsREru2gwdqvcrkdPI=
X-Received: by 2002:a05:6808:6286:b0:38e:37a:25aa with SMTP id
 du6-20020a056808628600b0038e037a25aamr1894736oib.56.1683380993695; Sat, 06
 May 2023 06:49:53 -0700 (PDT)
MIME-Version: 1.0
Sender: minkaylinmanth73@gmail.com
Received: by 2002:a05:6358:920d:b0:114:bf62:50e0 with HTTP; Sat, 6 May 2023
 06:49:53 -0700 (PDT)
From:   Kayla Manthey <sgtkylamanthey73@gmail.com>
Date:   Sat, 6 May 2023 13:49:53 +0000
X-Google-Sender-Auth: 6r9hyqSHYcLKcSz6GCShVL90clI
Message-ID: <CAC7nsSPJyRRyePe+oQk2qg+xQsZ4B-9X4X8+Z90RZBg1egY5JQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, please  did  you  receive  my  previous  email?, thank you.
