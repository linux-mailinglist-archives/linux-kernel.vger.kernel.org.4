Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA296D3815
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDBNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:23:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06145FFA;
        Sun,  2 Apr 2023 06:23:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so27973252pjb.0;
        Sun, 02 Apr 2023 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680441831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5a3n3mNG/Ln9NaWSMOa1I6Ch2ikdTdoVWYiwsPNZ1ww=;
        b=FAw2FQN7iUFhmfNoh4T9usPtLIsE0wM7LFjVaSO3I7mmAijM1gOu8kpzDiaVZ7ohl9
         T8iXDWJ2wApTAwkIyx8M1kgIzkPMhAe2oL5oeufJV7iDQXVinCYjQjCCD2j9qCqu8FPc
         OvHcj6EEe6Xdvkxm8mlnrf66VGlGp4QMDCko0Cg0WLTdQ+sfNEsPZ+EDgz0b9C3GmL7p
         VTAimn3yEgGWGDjx+rUA/KcQVc8L3g3AGnU6p0fINwI9dR9iIMlHnvmQQjNNxPhD0lCo
         feVbu8xYXmo5hmCMEnVQqtYHmcjibshfOfN0KOgT8iaH80ZKW3sJ77yv+GOFRINuzfGy
         LVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680441831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5a3n3mNG/Ln9NaWSMOa1I6Ch2ikdTdoVWYiwsPNZ1ww=;
        b=C3yvgdmLaILKe436fUscspqvfmmEwRC6MqmQ7C23cdNfUoGzOD7Az8p+d3KxmlkrV6
         9i0Z6kYruvdEK/xrp2FHlBJ7v3maFC/BiIyBW3U0IXoJDivytROx5UkgNqm6cF1KU+eK
         39++dCab1MwnnbnK22/hxkH+nIO7BmcIIVY9SIXRlwioOmtI9C8Xjw9AYS3Q6IpgqQPc
         9A7QqynbxU/1qNEKZ6j551WQtrdvwdEW7OqBZgBtujRDc04k6WM7hpuEMjoukoai+9DZ
         olBd8lUjyCYtAZB5lwi3MDKspzUKx5DjyNO0WLsLc45CzqmrmYuJ+6wRRDbp/kFHJUrl
         2k5A==
X-Gm-Message-State: AO0yUKXqF/HgsoMEfYgZ25E2n3Dngk9R0JeshDw3ODMzhGOxZseWgIeN
        +zcOfNU5qDmFC/ghEslr1pE=
X-Google-Smtp-Source: AKy350bz6Agr2tPQ3zn0s5AmrBBBZwePlBUyfKm7l36eWU9K3zdlr+rwj0cmfpdD28AI1Oignu33BA==
X-Received: by 2002:a17:90b:4a8b:b0:23f:1165:b49f with SMTP id lp11-20020a17090b4a8b00b0023f1165b49fmr34305342pjb.38.1680441831318;
        Sun, 02 Apr 2023 06:23:51 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a540e00b00240dee12285sm4335491pjh.34.2023.04.02.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 06:23:50 -0700 (PDT)
Message-ID: <e33e3a14-fede-6a63-7cfe-776e02e2eecc@gmail.com>
Date:   Sun, 2 Apr 2023 20:23:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [BUG] Problem with automatic kernel numbering
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Armin Wolf <W_Armin@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <c4c14e20-941d-444e-7390-8624024d3027@alu.unizg.hr>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <c4c14e20-941d-444e-7390-8624024d3027@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/23 18:54, Mirsad Goran Todorovac wrote:
> I am talking about a problem with the CONFIG_LOCALVERSION_AUTO=y feature.
> 
> I thought of a way to make an exact account of which patches were applied in a build
> i.e. adding patch checksum to 6.3.0-rc4-00034-gfcd476ea6a88-dirty, for currently the
> command
> 
> # rpm -ivh --oldpackage <kernelname>-<build-no>.rpm
> 
> install the kernels
> 
> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-24.x86_64.rpm
> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-25.x86_64.rpm
> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-26.x86_64.rpm
> 
First, Cc'ing Masahiro.

I think applying patches with `git am` should change the `git describe`
part of kernel version name. However, in this case, you have uncommitted
changes in your tree when building.

> all overlapping (apparently everything after '-' [minus] sign is discarded,
> so one has to reboot to another kernel, i.e. 6.1.15, remove the offending kernel,
> and then install the new one in the sequence of testing.
> The CONFIG_LOCALVERSION_AUTO=y rpm build script might add something that rpm
> command sees in the install process so the files do not overlap (as kernel names
> are being truncated at '-' sign).
> 

Patch number truncated?

> A smaller hash of the applied patches would suffice, considering the limit
> of 64 chars. Or using an underscore '_' instead of minus '-', so the rpm
> installer doesn't treat them as the same version of kernel.
> 

12 chars is minimum abbreviated hash length for Linux kernel, so it is
already sufficient. Personally, I bump to 14 chars to give more headroom in
case 12 chars give 50% collision in the (hopefully distant) future.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

