Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972D85F2407
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJBQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJBQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:11:50 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805829CB7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 09:11:48 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id f1ZBo06ecJvOZf1ZBo73Xc; Sun, 02 Oct 2022 18:11:46 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Oct 2022 18:11:46 +0200
X-ME-IP: 86.243.100.34
Message-ID: <e039d9bd-d2e7-a215-4ec2-7f760e1f83b1@wanadoo.fr>
Date:   Sun, 2 Oct 2022 18:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Content-Language: fr
To:     cmo@melexis.com
Cc:     andy.shevchenko@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel.iio,gmane.linux.kernel
References: <cover.1663834141.git.cmo@melexis.com>
 <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
 <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/10/2022 à 18:09, Christophe JAILLET a écrit :
>>   static int mlx90632_read_raw(struct iio_dev *indio_dev,
>>                    struct iio_chan_spec const *channel, int *val,
>>                    int *val2, long mask)
>>   {
>>       struct mlx90632_data *data = iio_priv(indio_dev);
>>       int ret;
>> +    int cr;
> 
> This 'cr' seems to be unused.

Ok, used in patch 2/3.
Sorry for the noise.

CJ

> 
>> +
>> +    pm_runtime_get_sync(&data->client->dev);
>> +    ret = mlx90632_pm_interraction_wakeup(data);
>> +    if (ret < 0)
>> +        goto mlx90632_read_raw_pm;
> 
> [...]
> 

