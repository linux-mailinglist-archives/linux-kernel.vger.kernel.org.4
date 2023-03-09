Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B576B2F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCIVXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCIVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:23:04 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC71BACC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:23:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 20FAE604FA;
        Thu,  9 Mar 2023 22:23:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678396981; bh=+hGwuhU60K6mAwLZxXBYBAr9SMiSZEzsIJwtAccX4pg=;
        h=Date:To:Cc:From:Subject:From;
        b=aXRLFMzA6nYOn0I3zveknpxCzRQwMVBHM2BlWcgwh57KG+oMqCUjcqW/D/F7DFq8e
         0GtRu6rRbHcF1tsyfY/LIS3y97KYY/gCzPKKvV01jLXPKDYBFjEW7MTM4QxFeyA9Zj
         8bFr5fTg4X/ylhOU02mugAdKsKfyKKXil6DSa7ZKbmqobdlcx8Dx2Ab+aRINGNWg2W
         8MzAge/oLCtGe+8qulxJktYzyN0CuCDz392Po/K+DR7tgad7T4GNRI0ATacPv1WFUo
         o+YeQH2R2OqrRZ3fTTCUwPvAqC0GLb6RbjEb3I+7Np4MlPriHnPTRNg+Zb3pXZs3i0
         0QprEEMZWpY2g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CnkvojpiYp0V; Thu,  9 Mar 2023 22:22:58 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 89896604F9;
        Thu,  9 Mar 2023 22:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678396978; bh=+hGwuhU60K6mAwLZxXBYBAr9SMiSZEzsIJwtAccX4pg=;
        h=Date:To:Cc:From:Subject:From;
        b=w+74QsxlUk50B72AontgrGGbOVCyByG6lRyGRpjuBR24gtXo5NChs1dtOgIBGZ9cI
         7cW/592G/YbTfJ+oZY4N3b7J1DrywfHnmrzugIKcg5qexc9TrIUvynlg2ZOcOc/UeR
         LOojI/jPXa6+cayI3he6fQUxkRNwF6voBnxbsbCxUwarK4iD/HIf4SZF2xBOQB8GWX
         WYLyT+nLrZCOk9DjMvZJjcEgx5l/F7YpaPgiYvSTjV4PvCd4xZWjjCgH4XH5fowLVZ
         5+cMMPmf71og+CTtOtfts8X5wbjdg+pAwLhxPj/rgH2oL8jaEtGM7NaWxE60+Fhoxp
         ElL0IIYaLVNNA==
Message-ID: <315b5e4a-43e7-f7af-f320-a5a3564127c6@alu.unizg.hr>
Date:   Thu, 9 Mar 2023 22:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, hr
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: A question about compiling Linux kernel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Bagas,

If you can recall, you instructed me to use ccache, however with frequent rebuilds
and especially bisects it would be better to recompile just the objects that have
changed between the versions, rather than doing "make clean; make CC='ccache gcc'"

Is it safe to just do make CC='ccache gcc' and let make decide what to recompile?

Normally I would experiment, but it is hard to predict what could happen with
63500 source files. Especially if .config is changed?

Of course "make clean" is obviously the safest way, but it might not be exactly
environmentally friendly :-)

I am not certain how git changes mtime and ctime when doing "git checkout <version>"?

Will make be able to handle this, or is it best to do a "make clean" and rebuild
from scratch. Possibly speeding up things with ccache ...

Thank you very much for all your support in the past months since August.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union
