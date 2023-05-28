Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055387138B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjE1IV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 04:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1IVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 04:21:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6EC99
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 01:21:20 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3BeKq1PKadSC93BeKqPZEf; Sun, 28 May 2023 10:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685262078;
        bh=nX3q8TDpBb44Pj2nFnyASQnvodZT+B9gU6eNR43xnl4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DQEUK0oIC09BxB9jlyKZ8sOzTZvByKbvEPUKL3032w4l1PHPaVpMcrtBDxy8yvDgx
         si0CX2bgGnK3a7TGQx03IsRvdOFXJ0xN4hoHOn1000htZQysdH0d1WiTKHJarY+B9c
         RORF9Q8nt4XvMD01PDjHOgvun7z0EK741mqY3w28dzoidp2a4+KmsdUBVbKizJ4SOG
         lUWbgsNVA68+Pp1S50KCDDhIarGKq4ZaPTyPu91y+htcNw7inwmqeVF76tNppa/rLw
         P7UM9yfdazMUC2dk+Ad0t6ilJrMMyzxKegB4Jyb+Eb9UGd0SvdOYx5NIy8P1elzWh/
         cMajQcBBMs8nw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 10:21:18 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ca50e56a-14c2-0c62-566e-cf00c0510529@wanadoo.fr>
Date:   Sun, 28 May 2023 10:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/6] ASoC: tas2781: Add tas2781 driver
Content-Language: fr, en-CA
To:     Shenghao Ding <13916275206@139.com>
Cc:     Ryan_Chu@wistron.com, Sam_Wu@wistron.com,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, gentuser@gmail.com, kevin-lu@ti.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, navada@ti.com, peeyush@ti.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        robh+dt@kernel.org, shenghao-ding@ti.com, tiwai@suse.de,
        x1077012@ti.com
References: <20230527223537.9686-1-13916275206@139.com>
 <1eb0d507-2017-4057-272b-cb3c298fa990@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1eb0d507-2017-4057-272b-cb3c298fa990@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/05/2023 à 10:04, Christophe JAILLET a écrit :
> Stop reading here. There seems to be a mix-up with patch 4/6.

Ok, sound/soc/ vs sound/pci/

I guess that some comments done on 4/6 are also relevant for 3/6 (i've 
not rechecked)


> CJ
> 
> 

