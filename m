Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100C6DBAE7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjDHM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDHM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:28:44 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFD113C8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 05:28:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id lz6so828200qvb.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680956868; x=1683548868;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuEcBNI44bQPUlx25Dk5iSkVIfTfkFa2bdyje0ZPA4U=;
        b=m4FJnMZIFuy8hr3RahtlO+tmM25RhraUUkzglLhaMY3bjMWnr2UBSaUjVp++YlXDQi
         46yl3jSH3PR5ylMmIraOro0D/LoEZtAlCDWoTxABtsknLxhMTSE/MI0L+3BNDARXsv1D
         T/yoNZIQa2JS+38zKrQ8Oe65zkD9gb6P7Cn5Y9DhHRzUT0CcjVlq0OkU+avpUbgHx9Je
         5OS/hiKpQFb+w7nZ5BOxxUwWKjYTqfzdQplIECR93W2SyGxBP8vrjZZlaFWupCn9fwHL
         s5DzH6OTLt5KPd3agluhTHsDmXitX5+cp2MaqknZb67QzYpsy5dRslza7G+ToLaZ3hjF
         Qt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680956868; x=1683548868;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuEcBNI44bQPUlx25Dk5iSkVIfTfkFa2bdyje0ZPA4U=;
        b=YpQod0jobuO0XvrJNE2/aDxz8wu9uy7pC5iGejUndolmzl2hhQ8tGpjUC82qBbFq71
         9EA0xLlEkF54eLylT6YydR00F3Qx3PtL8c8Z4PuDr3LZoEbt1To5Pn8XalBdz5vhKRQy
         1mQSCq1rrjI/2mgPjZV9N59oOhQsMBfZ3kB6vQe2QbiWZCAusuyaWytXMAGCq7TzkuYT
         FoMGiTNi6xj52svy7p8zrSw3xN7cFpRmM8EbyQFLxecqjIEa+INVw8nkxsed5nDzqI30
         LfKRaJ0VJdFXaWdxuJCIf1AND5bQ+5zZcYBsPO3Nk0FaCFs+C8RVCQ4Pa0qNn/V7lsw0
         JzlQ==
X-Gm-Message-State: AAQBX9e0MN/Jqld6Fk0Zy8wsMqz3PqaKcqjxi0wqmFTJuiZ6KA21FNGS
        ehj1HRORCgeuHFGwncImu2wRIc3y86Gjp+lNEuo=
X-Google-Smtp-Source: AKy350aASHeuTFN7C8sHnTz6UNwzY5/dD8OWWUQeRROpmYaqXkGz1u8odBbUlqdSpGfdDVnWS4giYxTILc7+Q9vKNpw=
X-Received: by 2002:ad4:55f0:0:b0:5e3:bdeb:eb0d with SMTP id
 bu16-20020ad455f0000000b005e3bdebeb0dmr428569qvb.1.1680956868058; Sat, 08 Apr
 2023 05:27:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: lindwilson141@gmail.com
Sender: ibrahim.kabore1985@gmail.com
Received: by 2002:a05:622a:452:b0:3bf:aa97:fefa with HTTP; Sat, 8 Apr 2023
 05:27:47 -0700 (PDT)
From:   Ms linda wilson <lindwilson141@gmail.com>
Date:   Sat, 8 Apr 2023 05:27:47 -0700
X-Google-Sender-Auth: hI1ZS3DJIuB0_YyjTgdYoPLSWsI
Message-ID: <CAMumKkk6NJs9fd2+NRpxFYmLgJh6tD55banzdmJBjQXgu9CBVA@mail.gmail.com>
Subject: MY WARM GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dearest Beloved One.
good day how are you, Why I contacted you is because I have a Very
important and urgent
for you, awaiting to hear from you.
Ms Linda Wilson
