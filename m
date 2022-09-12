Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DBF5B5CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiILO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiILO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:57:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDC2F642;
        Mon, 12 Sep 2022 07:56:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e17so13203771edc.5;
        Mon, 12 Sep 2022 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2dWFEiW/Jc7/giL2BERMTjPyZNMLvZ7v7O1nwKU4QvY=;
        b=bVaB0T5Vb2Icj5t+c+UzvRITjianErSDPy0QjcEwngELQR65UIByY4CnAhreTEV5IS
         q1aX5AItX6sviaMuAHENLhWg/FL8sAU1aYRm//4I71zC141zXORiZ4g5tVrk36G0sGgT
         yffTWCBtDajs81hpWH+7juev6ts/4lOI1YMIbyyWtpqWXa5a44L1ekTMW3gzA+8ZbFky
         zAKuTgSkyJJ3m96kTFQuqh6yS3vfBN5xpbjV/g/uHTadAm/nNaHhtZd73Z8F+8v+HdNV
         cisdmljbypGRl6OyqNBFCGb/iLTlCsExa5OgzejbM6AKNRVzw0kf57Qn9OABupbkJNpL
         J1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2dWFEiW/Jc7/giL2BERMTjPyZNMLvZ7v7O1nwKU4QvY=;
        b=f50vU3vmvQbCFZBNwDZpaFYm8fQQEdkOGVg3dMGFpZWPcmuBbboTiuHby1m722XJDx
         s8SnQR+3BRDBYFFtJBjGphrVqzipaIbWYpxLKeuAT+y/CPMM2ti7ZTwGc/fqHmm7PPST
         FKiQeviwzV0VTSOZKu2qKZrh4On8sj2TFNp9YJ4UMsjTg9tcQpu1B4992WrWS0gUQ/k1
         WwLozbrzzjz/G6KT5XhguUiBTlVi6QvcFpkgMdp8lH0jbKJpObVguOded2TARoS9EYno
         JzrZ60YMxG0tFrCw0j5BVTABpYJCtPkKWmvTl8RUZGJIpBv0iK+94UVBQJhuhiNp5A/e
         feKg==
X-Gm-Message-State: ACgBeo0Hzwd/RRjDUmiu+l477Zzf6XmZKaliEJY2Xdhaom13JSB0Q9Sw
        fiwXNCBZx4xi4RZee1qiXaLutKNl+4M=
X-Google-Smtp-Source: AA6agR7GldEsgIfBUKuiXFeGDHznoY8OXlP4X1ZF5HwYrEjCyr6JL5VaH2jhWzt4nLR2o6XvYu7XoA==
X-Received: by 2002:a05:6402:198:b0:442:da5a:6716 with SMTP id r24-20020a056402019800b00442da5a6716mr22338879edv.5.1662994617678;
        Mon, 12 Sep 2022 07:56:57 -0700 (PDT)
Received: from rog (dynamic-046-114-143-092.46.114.pool.telefonica.de. [46.114.143.92])
        by smtp.gmail.com with ESMTPSA id fw18-20020a170907501200b0073dbaeb50f6sm4535251ejc.169.2022.09.12.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:56:57 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:56:54 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, catalin@antebit.com, Shyam-sundar.S-k@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Message-ID: <Yx9ItlBjl6bxxu2H@rog>
References: <20220909180509.638-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909180509.638-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario Limonciello:
> It was reported that an ASUS Rembrandt laptop has problems with seemingly
> unrelated ACPI events after resuming from s2idle. Debugging the issue
> proved it's because ASUS has ASL that is only called when using the
> Microsoft GUID, not the AMD GUID.
> 
> This is a bug from ASUS firmware but this series reworks the s2idle
> handling for AMD to allow accounting for this in a quirk.
> 
> Additionally as this is a problem that may pop up again on other models
> add a module parameter that can be used to try the Microsoft GUID on a
> given system.

thank you, these also helped on an ASUS ROG Zephyrus G14 (2022) with
BIOS version GA402RJ.313. Patches 1-3

Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ

regards
Philipp
