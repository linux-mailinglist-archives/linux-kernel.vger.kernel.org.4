Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C445F4AD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJDVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJDVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:22:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BD6C762
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:22:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso36832wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=MBeztxG+T/+sAKzXrApPY5wTqy2P03wfdxdSIiSCo6s=;
        b=gUoVGj4t2QziOa7am2zum1d+q/o6w56i6RIUOdKZOFcWYEYFYGtZoT4ney6oh7RFa7
         HadQ7shyyVEYW4peoJSatplGdR/jPdlwnbIpOnrpnVdUwb5Vb4w8NKmujuac8Z0pKdZC
         6LBUu6pYTZlQa9LXF42bCFfp/zWW9oyhXDZ0DR8wLyA11aVJcgtwybK9uN75Pyk+Cr2m
         YstJ0lsz07uYbQK5J5qXx+q1xNYa4GFz7JVs8tJL9/aMx5dXo+ujNJ610qSbF5VNgWWu
         5y5gJbzI2a4wwm+IwiS/uY4u8jzhSIejlJTOrE9y5mFgNlpww8vFq59hTbEgCHZFVkZ2
         J/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=MBeztxG+T/+sAKzXrApPY5wTqy2P03wfdxdSIiSCo6s=;
        b=zE0CGhah8ik4yh3sH/a7xgRtzt4kY3Yu3LBe+n613+A75VITgBXd2ZdtKwNyg1dnOL
         fIHa/N1RFa5/a+U1dcLP6ibGD0UgReXCuUwWhXAVPLIaI8+QlnV23XtGOWfHcUJIpmjv
         z3cyfYJO8yDvQZdP902Ayu7ElYJtrlPVZZR2kQzzNJh4NLl/lV7pqiHEL1EVQ0hh5/iy
         KBcu24K/jOOHKRDcj5Xr33vItj2KNZ9Etrsjb9mqymsLhkU8ntuJ5PCCGTtaxxUf24Du
         2GSn8dAJJUsQGIVEjQTs8M/7fd6M3nHnMSRQ3CkMMF7Wu2Cx2mFS3/tSO0xSRn4AHFhU
         5cNg==
X-Gm-Message-State: ACrzQf0MkG1aEXXurLXqNqv4DBfwm61iobtSi88lavqRJKMjIVFSB9ft
        kszqlmPJQcD/S6YfP/AHojM=
X-Google-Smtp-Source: AMsMyM5P+HUH+oZADCDQokwKaZT14vAK7fJPP+tWkbvXiLAH3BnGR+omUTm/5JgfKxek5Lrtj2l49A==
X-Received: by 2002:a05:600c:5022:b0:3be:ed8:9a25 with SMTP id n34-20020a05600c502200b003be0ed89a25mr1053128wmr.194.1664918556279;
        Tue, 04 Oct 2022 14:22:36 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056000137200b0022cc7c32309sm13485044wrz.115.2022.10.04.14.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:22:35 -0700 (PDT)
Message-ID: <5799ca65-df15-274b-3319-984f5e1f0fd3@gmail.com>
Date:   Tue, 4 Oct 2022 22:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: fs/ntfs3: Add option "nocase"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with clang scan build has detected an issue in the 
following commit:

commit a3a956c78efaa202b1d75190136671cf6e87bfbe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 23 12:42:18 2022 +0300

     fs/ntfs3: Add option "nocase"


The issue is as follows in fs/ntfs3/index.c in function ntfs_d_compare:

         /* First try fast implementation. */
         for (;;) {
                 if (!lm--) {
                         ret = len1 == len2 ? 0 : 1;
                         goto out;
                 }

                 if ((c1 = *n1++) == (c2 = *n2++))
                         continue;

                 if (c1 >= 0x80 || c2 >= 0x80)
                         break;

                 if (toupper(c1) != toupper(c2)) {
                         ret = 1;
                         goto out;
                 }
         }

...
...

out:
         __putname(uni1);
         return ret;
}

The exits in the for-loop via label out are ending up with __putname() 
being called on an uninitialized uni1 pointer.

Colin

