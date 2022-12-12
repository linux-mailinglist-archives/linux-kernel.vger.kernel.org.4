Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77BA64A561
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiLLQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiLLQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:58:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE522C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:58:05 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n3so285007pfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=h075/4KBipl75i+qcbTOfbrFsPq8iEQotfPxfuhYMqj24v9WjOesYVdT8myjS3J2yJ
         KC0mosGMsEsn+9NHyDlRfIkRnWbQIzEn4npVXIvHURgAm8lErDBCdI+LYWEYWcweQ8O3
         uqkOQs/BtyDO/yJlbJ1aBvWorGD4waLV7qcuWqnvZRYmCc+hACLGMOj6VTV3/CmBxXZK
         Z5XXRCKQUqw/+IFaarEZ2ccBNWdHFyMMIUl90vJjudcMxqoO7I1BX0lXrXW8pVElRII1
         +sCOB24OyP/C72J+3JcV/Szv9RYhOVDVFrBRDllKDrn4V3MYm6qsaQ808DyhLASZE68c
         iJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=BNfZBqGqzD0oih0wqqCgwyIaxSH2ozdFlfYohQNN0wmYEKooQkqevx2sx7rqTSeVn3
         KbHy7TdJd2lFwaqQSel8d0q8MmmAe92Tvx3tzRpY3rMmSiBjDL5CYg9B24ffW4wIUpUH
         4PHYKF74+Vnv2HQD7IV0dDpSAw0lwYlzp9EuxUzXXf8mlLCzKtmrDheK8d+W0OlGM0Ny
         9UlFiHDCXFZumMg5EMi9RzngElcORwrAmr6pX3w+b2gyt1Kg5FzcsVkVCkOcO6mFQEXC
         zbtXxoZq62xGEDW0dMpq/vIy9bJOZzjwaW3+CBj4mrdW+hh+I/0/s69Wwx2VSp5YoQZW
         rjcg==
X-Gm-Message-State: ANoB5pkqCg7b/odg1v6zPRT5p0Eu9QFrSEn5ohp6VsSFqQdKSKZ9Aw02
        TbtK9S84c0hOke66NJ0nI5nhbQH+kd4OirsPeII=
X-Google-Smtp-Source: AA0mqf4+1IqAc4lTXpFxKZfsT7AeyOyeZLdHkQVIK8c53H7+CGU8I/QSB/8cQTITDTMN/YVpuMKdoW+QMNvGl2lbtdQ=
X-Received: by 2002:aa7:8f2c:0:b0:576:ee6a:55ca with SMTP id
 y12-20020aa78f2c000000b00576ee6a55camr18819622pfr.38.1670864284617; Mon, 12
 Dec 2022 08:58:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:4416:b0:47:5338:655c with HTTP; Mon, 12 Dec 2022
 08:58:04 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <aidenalexander304d@gmail.com>
Date:   Mon, 12 Dec 2022 17:58:04 +0100
Message-ID: <CAMw2Taun-_9nbv_r=D4sM_+CfXAdaxvS3HGYTeBvchfwFPQqsg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Your Faithfully

Mrs Can Yeu
