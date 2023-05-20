Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09870A7AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjETMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:15:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE35E1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:15:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ab3e8f4efeso21833181fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684584952; x=1687176952;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKiEc/q5NVJa1ONcEFLpvWSx5WNl1YdXTMpRPT6Oklo=;
        b=L14uQnvTKP9MGnp3Vv/dcemOI7E0doubohHMG3FtZb8wURgesyeUoeScLXs20m8H+Q
         Gvf7EZZutJbZhrMSgypzLix9B4hxwMn/GXIuLmw1JaBoavjLBclkJ1eIo59PazIRNRyl
         AcYUkY7gmHwyQj9+EEY0gUsmbUnlD58BJQKyboR3YIbLMZzsbJmpLL0gjN7ftjd0bjGi
         fcJyAbBWcHqfzzrtvcTTwjKkT/W5NmDdpzDVwhthASDxVU6vil897dEzrLuUXOoYKbgn
         6k1Fe7BCm/Abb058sPkOiF5BpUqpi6Pi5IpO8StREuQ4JfwxGFgM0j89USHvmaNczrLO
         2hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684584952; x=1687176952;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKiEc/q5NVJa1ONcEFLpvWSx5WNl1YdXTMpRPT6Oklo=;
        b=YD3MY03ejSl6eVrqjtMeEm0Ezp+a80/KWF8yJQM0wC98Uw5I2cZnDZlJ95kPzDin2j
         TarW/mgjhha8nzMAD0xkzZ27z7BFFz0bXgIbgX+7F4+T3E6kYwgk8Jmrb2+2a/NoKlja
         yCFOM8MMjmKbwyUz30JrYXYchQ99+LLDlr+997Qigoh5kH4y4nBCfSj08E4Oq50KlqDc
         RxDK71nMmZ0KIaizBOCeB03WBL/0ldtuX+qDih4HmUg6bVCvewb0f64Qlj1QyPh3X6Pq
         8Reu6683oW2BHs+6dCJk6y/OuTmhMpuBlcV59nklrMnIOQViL0j9aNe3hzncgOqdFDbH
         L7eQ==
X-Gm-Message-State: AC+VfDzNWHMh+JO6wJKOfwJGAsqlB/lhzJw02Oz8hjtYhZUmNbuCseTu
        rzKEUx/7FthWP2rALQBeCOIhwJCMkiVoKrVE6YU=
X-Google-Smtp-Source: ACHHUZ74PRWd3W6tA7/HC6ffJ6hUlzKNVHe9tEKAitrJAPUnK5rORfUJbbMWQJ108I6ExXGwTw5z+wSbP/q2dJlyD08=
X-Received: by 2002:a19:f816:0:b0:4f1:4074:b4fd with SMTP id
 a22-20020a19f816000000b004f14074b4fdmr2155614lff.29.1684584952032; Sat, 20
 May 2023 05:15:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrr.patriciajuliawilliam@gmail.com
Sender: stedoni745@gmail.com
Received: by 2002:a05:6022:6114:b0:3b:959c:3e0d with HTTP; Sat, 20 May 2023
 05:15:51 -0700 (PDT)
From:   "mrs. patricia julia william" <mrr.patriciajuliawilliam@gmail.com>
Date:   Sat, 20 May 2023 05:15:51 -0700
X-Google-Sender-Auth: uwljhLZb7D7C7ft08Wd-WR2cUKs
Message-ID: <CAAWQ0g6yRkCp7XdF0XZEbKu_LBYeyo7g3BTBkM8cgjvxnq14rA@mail.gmail.com>
Subject: Yours sincerely,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Dearest,

Am from one of the cancer hospitals here in America suffering from a
long time breast cancer of breast and i want to donate my money to
help the orphans, widows and handicap people through you because there
is no more time left for me on this earth.

Yours sincerely,
Mrs.Patricia Julia William.
