Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15945F2408
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJBQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJBQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:11:54 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E59829C81
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 09:11:53 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1of1ZF-0003iV-N7
        for linux-kernel@vger.kernel.org; Sun, 02 Oct 2022 18:11:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Date:   Sun, 2 Oct 2022 18:11:44 +0200
Message-ID: <e039d9bd-d2e7-a215-4ec2-7f760e1f83b1@wanadoo.fr>
References: <cover.1663834141.git.cmo@melexis.com>
 <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
 <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     linux-iio@vger.kernel.org
Content-Language: fr
In-Reply-To: <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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


