Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4269866CF24
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjAPSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjAPSug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:50:36 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC444A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:50:35 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15eeec85280so8603711fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfI+7PigVR173TrnHI8xEn/1neEETE5LuyjymlafkFo=;
        b=qsAHziFnh+gblQ5HpY1fmR1AZ9n9saxQefPx+jaotMwhdzMZiImm+4nyEMrILGKtCh
         O/PfeiA08GnvN9dtqoobsH2QiQOKtbGLIJffG71/ePUkIyNv9BkJF5dmtzTZG1Onoqei
         EqhJpY6lAejOJ9o/lzTiJIfXmk8MEflxSbcAjyAgUVXY1eWtZP/gX7Oj8YqGkeQ8l8n5
         q2BlJYlwIZ0Vh86hCnBDP7JTIp3dxkzRhcU4aevUbWih9iDV4GAr0nJ4Yqqjcg+oipxt
         hQsQ2R5ZGDbwXVJKr4cvBwDVtyg+QsbgoAGxeykKgn79AuiTEBEUbpmSMIexwt47FZ/y
         LBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfI+7PigVR173TrnHI8xEn/1neEETE5LuyjymlafkFo=;
        b=tWcOWOrkzOhKlcwX+QF7D/Im95uhnGHXYZ6rICyk777ZUd0ZEOYm+JYAFRxW/6ULGV
         bcVIa61jdXrj7bJ/Mh+XESRhNlQAMqBdjQuPtFZ/nXkZejYo3k67KRERgsUcTXNHg4yZ
         kBvIG5PFPSBM+zA3W/cL3b3+WTsNmDn4JbGgr66WCNh1PwF4UaicTuskOK7D0MATHpAU
         jX9hWo0JV0T00i7Ajz/ZkaoOlEGqrl84y7HiDAomBbZ4zRstkWTj/bB1SHNBhsdhUXFy
         xxfsMn963sOuz9l9bnvShkiDyPMDYi88g8nvaOFIsEKI3Y1IHAysqO4kjDw32jqj2DcS
         2qYw==
X-Gm-Message-State: AFqh2kompMxUF7AuCO1LfyjwvW2KKK+9RlVtyuw6X7LMA8B+chgH7enP
        JegJAMNPS1uaxUjxojpymg/1NMzy/xw=
X-Google-Smtp-Source: AMrXdXv/5CCwNv0SpIIZJeA5ME6g9M6Ka5gBZNoWz7BBfEyjDoysGjzhuFzGCIyJuJYBS8eCR8cDhQ==
X-Received: by 2002:a05:6870:8dce:b0:15b:9e04:4f12 with SMTP id lq14-20020a0568708dce00b0015b9e044f12mr356142oab.45.1673895034938;
        Mon, 16 Jan 2023 10:50:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f18-20020a056871071200b0014f81d27ce3sm15081453oap.55.2023.01.16.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:50:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 Jan 2023 10:50:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.2-rc4
Message-ID: <20230116185033.GA2027409@roeck-us.net>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
 <20230116122924.116745-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116122924.116745-1-geert@linux-m68k.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:29:24PM +0100, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.2-rc4[1] compared to v6.1[2].
> 
...
>   + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28
>   + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]:  => 641:28

Unless I am missing something, the code is

        for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
                size += q_data->sizeimage[i];

and both mem_planes and comp_planes are <= 2. How does the compiler
calculate an error subscript of 2/3 ?

Guenter
