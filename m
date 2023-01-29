Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9917867FEA3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjA2Lr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2LrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:47:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF33212BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 03:47:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so8660875pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoazifkbtFJztUrCUoGjKnW8RsZbWWLPaoGlneRqOrU=;
        b=gAhBl7l4r9LqwU1ROb1AHTQLdmPa1gwLsyRd9OuSQCt5PZuD1JeR2j+AlOrEJjA5Ni
         A7vtf5Br/Me7OqOkn9G1XT4tpCYqs8SvMhdVmSEcScHwcCPiNMaBJacoGKrdU9qPD5lP
         VQW6b5bUVwrXcSSIp8xeV04PY2T/LDuBMJdIA01i9Z8aQWSdP4cuUNvbGghP6Gv1USVc
         5sXCyeBBFJhS+UxlK5gGttCcRnsMnH2C/mp7xn3MYznzlmZPlKeBZ5ocDbsaEcQSqdLd
         wrdciXYUzqk27RP8qt8BFNWG+ngN8Ld8mdf95xXEmyX26olo164K1rgIOdXxF5YZACuY
         XbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoazifkbtFJztUrCUoGjKnW8RsZbWWLPaoGlneRqOrU=;
        b=V463twUVs/tawpdbfkC9i045sZe03bqUSxe4CaI4Lf5U0jePc89zMqv+NdJmg/sPAB
         F/LCjgED6XDbfJ2ouoW/b70dfFFz81viCstUjXpo5mlvCTGn2TR+sWBfvr8bjy0Weuu2
         67iZPhsi0stUrrGZzBI8Uhn2ib+opkYx20h9SfdAiTZi4Ehscm8g8AnXQoePKEA2aNcr
         KHNyevLyTKP9ssENmC19QmzzGGU6gVGeStWFetYCEuVfn+NJFEuXETSYb23k5f50noU7
         bH5eQc47bJwJr/u4HiHncILUpkMblnKoG/H0MIHMZhLrNjO34JqWUFFcp7jqc6vG5+XP
         Fnyw==
X-Gm-Message-State: AO0yUKVgsMemWd+lzS9fcMc7yyf0MqhchusQme3XmMVdjarFtXL/bcO3
        DqabcYS+CaysDDF1CaMfEiY=
X-Google-Smtp-Source: AK7set9X6O15t8wm1mu6GVx5f4CuJYVjgkIDWUb1IvHqEO1cTzvq6FHxXO6IHi4n/1PG3AvIAWMWMA==
X-Received: by 2002:a17:902:f392:b0:196:6ff8:69b8 with SMTP id f18-20020a170902f39200b001966ff869b8mr2702500ple.27.1674992843575;
        Sun, 29 Jan 2023 03:47:23 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id jo8-20020a170903054800b001946a3f4d9csm5851810plb.38.2023.01.29.03.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 03:47:22 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:47:17 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        xiongping1@xiaomi.com, qixiaoyu1@xiaomi.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: f2fs: set *_data_age_threshold according to user_block_count
Message-ID: <Y9ZcxUjQs4Hb0ZoT@mi-HP-ProDesk-680-G4-MT>
References: <20230117115702.GA12653@mi-HP-ProDesk-680-G4-MT>
 <20230117133814.79508-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117133814.79508-1-frank.li@vivo.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:38:14PM +0800, Yangtao Li wrote:
> Hi qixiaoyu,
> 
> > The block age here refers to total data blocks allocated of filesystem between two consecutive updates.
> 
> Yes, you are right.
> 
> > So, it has nothing to do with storage size.
> 
> But I think that the total data blocks allocated of filesystem between two consecutive updates
> has something to do with the storage size. For example, for a 60M f2fs image, the lifetime_write_kbytes
> will hardly reach 10G, or even 1G.
> 
> Thx,
> Yangtao

Hi Yangtao,

Block update frequency may related to applications and usage patterns,
not storage size. A 1G f2fs image may have a similar block age to a
10G f2fs image when running the same program.

So, it might not be a good idea to decide the *_data_age_threshold
based on user_block_count.

Thanks,
