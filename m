Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310726ACBBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCFR7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCFR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:58:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC353B202;
        Mon,  6 Mar 2023 09:58:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so42065769edb.12;
        Mon, 06 Mar 2023 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678125440;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNuvzB+TSHIugUyd5R6gfsD6TqRRXjxVT1Jl36UQtBQ=;
        b=bM/riuDLefTOSz8S5q55pCigDV0vMN+Qg0LyTkrRkrGt17wi3Auf6C/zBC1NZcxo3t
         fhtgBzMg2VXcVbqSRGIShAZYDGwCQ1QfFVIOVF+/MkgpPy9WD6d7V9xs3vOU0QEcMw3q
         kqkPhsWpeEuTEusu7PV7fLv5AKmBJsknYrsHSV4Oky9qTNJo0jno4ewGJLpH1J6XhoU4
         Pb8iKPswhyB3sfQkDOTohaji23hCUQRljEgx5OE5vXfL/KPX8jo2vZyRtoErgCEE6IXi
         QhXB1VILr9or9pw3rIAr74uC7IAoN1dVOv6DJTsVf5RU9FBgqExn8avcmbW0VCaj040C
         EUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125440;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNuvzB+TSHIugUyd5R6gfsD6TqRRXjxVT1Jl36UQtBQ=;
        b=QA1n3HrMEIAFTFaYdhjb/S8kM8wJMwW6T3OP9Z2jj0OezhVeV0orWEDwLIaMvYSdCg
         oOWztvjXSTUzfD+vyLJYo8QoimrwYNhUbpGE5g7oLhp5kbe8Gvd12zDfQTQyiYP5A4SR
         +t4mPmppar+XNn8qSGWBRSIypVnRqL+ZDGBOcAAj+YDO5FZIZCP5m6ldH3/7j2iZ94gD
         GHETJu8QDIl/zm8uQ9UOTqAVqc7II5xx2wRkjqp4+daxOmLiSGmTsYqcQvbbmFNw5vrp
         tm2Uqy7DOaX6c2JT8hIbsn9AmlX/HFggn4dlhbMh2Z5R5tU8spOQ+7nPeamSs/UpHpXB
         osVA==
X-Gm-Message-State: AO0yUKWeEr553gl6Wb7tEUZbZFgn2/Bz34l0xjbcRaOk6LtiiwOY9zs1
        hDYbrBUK2pgjFvFDaZ+DcCU=
X-Google-Smtp-Source: AK7set/AOH843okC/PhQJvlpygznYOmrc1PLZlWWcD/XQrlualHRzJJCGFDf4c1Jk8hshDVryAju3g==
X-Received: by 2002:a17:907:7e9c:b0:8b2:e6f6:c20a with SMTP id qb28-20020a1709077e9c00b008b2e6f6c20amr17467502ejc.11.1678125440254;
        Mon, 06 Mar 2023 09:57:20 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id rp21-20020a170906d97500b008de50990fa7sm4835243ejb.21.2023.03.06.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:57:19 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 06 Mar 2023 18:57:17 +0100
Message-Id: <CQZHTJDTRJXM.3OF3W3WAZBLAK@vincent-arch>
Subject: Re: [PATCH v3 2/2] dyndbg: use the module notifier callbacks
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Jason Baron" <jbaron@akamai.com>, <mcgrof@kernel.org>
Cc:     <jim.cromie@gmail.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
References: <cover.1677861177.git.jbaron@akamai.com>
 <5884c688d10c9703fb0457f8839d6becc8657f8f.1677861177.git.jbaron@akamai.com>
In-Reply-To: <5884c688d10c9703fb0457f8839d6becc8657f8f.1677861177.git.jbaron@akamai.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Bring dynamic debug in line with other subsystems by using the module
> notifier callbacks. This results in a net decrease in core module
> code.
>
> Additionally, Jim Cromie has a new dynamic debug classmap feature,
> which requires that jump labels be initialized prior to dynamic debug.
> Specifically, the new feature toggles a jump label from the existing
> dynamic_debug_setup() function. However, this does not currently work
> properly, because jump labels are initialized via the
> 'module_notify_list' notifier chain, which is invoked after the
> current call to dynamic_debug_setup(). Thus, this patch ensures that
> jump labels are initialized prior to dynamic debug by setting the
> dynamic debug notifier priority to 0, while jump labels have the
> higher priority of 1.
>
> Tested by Jim using his new test case, and I've verfied the correct
> printing via: # modprobe test_dynamic_debug dyndbg.
>
> Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@gm=
ail.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@int=
el.com/
> Tested-by: Jim Cromie <jim.cromie@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> CC: Jim Cromie <jim.cromie@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
