Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EC6807B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjA3IoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjA3IoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:44:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E525199F6;
        Mon, 30 Jan 2023 00:44:02 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hx15so9991024ejc.11;
        Mon, 30 Jan 2023 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rlfqax9aRXWEyb0zgMbgzjfBWfYrTNY0/TcN4EW8QDk=;
        b=m3t8NTGmpDsBmr0z5cmo45FFaA6FEbQMfSplMzwjB5MFl3+83SDXOLkxeG/yemtRVK
         o9ZtiZaa2Ggaiv6k5+wn6/xxMRMDwAb8bRNtB6xjsLVoX8XO/vkhnV6bZF5O79nWFHyB
         rRMKppKxFBn7NJRQHofm5CvSf/fwpsGXc37WufZmHbgMxrr4sOYHgzQsC6Jv+efw/GWc
         YfS6JqpXvwuL17zOCsV0IzhySQ/BDz5NSwyBMBbGqMAIiiDvy3tRvekOeObrU48p6SsV
         RK7hpSy8hwRCJ3oKKY48m2YYd9DvNfVubYz728MPmvcEegjC+J4ThyekPfpQVs+FpUxc
         zUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlfqax9aRXWEyb0zgMbgzjfBWfYrTNY0/TcN4EW8QDk=;
        b=AxG79d8vLVNDUC/xpkPYr07bOCgvB032CrTA96ZrN3NDJabd8BDrNBIDeig90WoScp
         S9LN4saZlud692nIkUFBf0Vjn5Htanygc7e2SBfiGq50PuZ8b5psthbT1kVfwvl1Gkh3
         JRsobbc1FkbcdlUw+qXsdvBC2bU49LghQ1r+Ir/1penO8fnvssXhzY3kfQ/UUy+O6c0E
         R9fPJa1TOVI9nFk7tGjKnfgww88YZYudJ8/uSn1l4JcsMgfW5pGZxkHwDNzDgqC3n6Ta
         Afv3FNrEXYUfDUw21O8xVG9nNDwAGXPRRuaDOxHA6h3K241A1p7itX6EkrtLkHkqP7XN
         EU6w==
X-Gm-Message-State: AO0yUKWR4ZnRj9WWUNKgugMD3APqrEW4mu0w+OmkJ3QB6KYs3LkMH4+7
        HLXIsrczxiOnniFCS+bb7g1pcGIJ6dgWGePjrLY=
X-Google-Smtp-Source: AK7set81vZRR6xUOAg5sNFfsPCU4HcBHOKVo2MB5yL2NoCYwYPapPNxMvKyV+8I3zLoLoCgkJphmmtpSuPQfR9HmCo0=
X-Received: by 2002:a17:906:d8ae:b0:87b:edf7:3b38 with SMTP id
 qc14-20020a170906d8ae00b0087bedf73b38mr2265418ejb.50.1675068241063; Mon, 30
 Jan 2023 00:44:01 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 30 Jan 2023 09:43:49 +0100
Message-ID: <CAKXUXMycsUQ3aWbAHa6fnSwmQpTt9PhagY14_k2sKGC+vGiqGg@mail.gmail.com>
Subject: Dependency on non-existing config I2C_DMI_CORE in commit a2f416bf062a
 ("HID: multitouch: Add quirks for flipped axes")
To:     Allen Ballway <ballway@chromium.org>, linux-input@vger.kernel.org
Cc:     Jiri Kosina <jkosina@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Allen,

with commit a2f416bf062a ("HID: multitouch: Add quirks for flipped
axes"), you add code that is dependent on the CONFIG_I2C_DMI_CORE.
However, this config symbol has not been defined anywhere in the
kernel repository. Is this a mistake in your code and you intended to
refer to another config symbol? Is there another patch to come that
adds this config symbol? Or is this a config symbol that only exists
in some out-of-tree repository?

Something might be odd here, because this code is effectively dead now
with being dependent on a non-existing config symbol.

Best regards,

Lukas
