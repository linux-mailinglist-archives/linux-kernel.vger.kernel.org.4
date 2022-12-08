Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA6646894
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 06:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLHF0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 00:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHF01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 00:26:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EAC182
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:26:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so1339025ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 21:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyAC9pGA3bM4rM543zM+YmJ53hSTj7w0+tIgvP3ytYE=;
        b=mk7ikO7V+gLhSvJNXyc0Lk4Q5twTTGLGzvBjtcO50S2myHLd3dRMs3AplR6ldR1vYw
         oTCXkBm/rTVIZ1aLvYupS9oaCIzAIKuMabD0ozybMvsi0Hnu+ZTmms7YRkl2GYxDN3K7
         ut3jQ4mW2Z2HLPwkkXS8G6GWIEpUL4W+aT0z3kdE72owhIZJRy8GqL4WcMLiZj2kzkSf
         OYa78jBZcIkAgQS38MmgzbexmjZvyDOecL0pAGinIWwEfk3l4Ahgp3UWs6qhTI2Pc3rx
         4WNuIjJH7KTqhqX1Vb7zmRqc6p7T56oN1CaN7h8YWF4mq7K2b8ewUVd6kHpWL15GLzTt
         BxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyAC9pGA3bM4rM543zM+YmJ53hSTj7w0+tIgvP3ytYE=;
        b=Hvkj9rZUiZ5uIpuElTJX49YLDK6tSm+Y5eOyaRR4Awj8r3vnx2XgtxwQYWukBccgD8
         QOQO74BlxY1A/sX03djO40Hhpg3mKJe4Xa9MNBgrBRgsqdRQ7RW0TS2XeEFMOpAcwbp0
         H0R7Hkme0rKphKig161OjO/+oXdrYYDr/BHLZCz3mpTFeBHMSQQ/sLqRvEjVoSPQc/q2
         Ce4oZrPmxiyregKWo3cfGrEK0Nz/T22FSzZtTSI5TzGwrGfMYBjKycLEKOGQKkepoziL
         NIw1VfYgpvKoe1RdxGzpYXonmp7CL+RXjcKTLmuuYk/j5rT7Pp5W+aXiV1yJTCKCoUVU
         zVNQ==
X-Gm-Message-State: ANoB5plWBpFG0B4WKdDL1tVohifU8m7sTHtkCGe6MwEYubCKJCUdQy+m
        TIjStSBcnCKlqMOgXcAugZwi5yfwdBcN393RHeM=
X-Google-Smtp-Source: AA0mqf43fy1U/hpgFgSTREx9HqRRsJ39IsTXgb3/H/MmWwCZn8wtF2A329/yX7mw8nW7vz954oj7UeqlYFgpy7oH7kc=
X-Received: by 2002:a17:906:ad86:b0:7c0:7e90:ec98 with SMTP id
 la6-20020a170906ad8600b007c07e90ec98mr9243580ejb.537.1670477185246; Wed, 07
 Dec 2022 21:26:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:55a8:b0:5e:5428:fcf9 with HTTP; Wed, 7 Dec 2022
 21:26:24 -0800 (PST)
Reply-To: abrahamamesse@outlook.com
From:   Abraha Mamesse <bartolosimon105@gmail.com>
Date:   Thu, 8 Dec 2022 05:26:24 +0000
Message-ID: <CALmWg1jQaUWQ5gS3mUYd1LXXgpzeDH1hD3N44xpAfLUyUb=gKw@mail.gmail.com>
Subject: /////////Good morning,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am contacting you again further to my previous email which you never
responded to. Please confirm to me if you are still using this email
address. However, I apologize for any inconvenience.
