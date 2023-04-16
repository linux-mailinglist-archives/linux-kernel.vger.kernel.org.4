Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C036E3590
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDPHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPHOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A181FE0;
        Sun, 16 Apr 2023 00:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52FD960B79;
        Sun, 16 Apr 2023 07:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47461C433EF;
        Sun, 16 Apr 2023 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681629258;
        bh=L46nArzumSSLHcWnJ3YWQnpXuT7YPKPy+4ZtFEJpikM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NLmvu/ZEv4C5JvNXk+YTibqBxpRVTDdheI/KPJH2BQT+aRlJ59ZXrkdFxORgjS761
         yO6bMQRhvQBx4iXGiUMkoA1nwloZgEtLR/s0pzlF4f7ahxuvzxhBwBajPJomguWO87
         WLPn1vDcq1iRuyx3u/HQu8+9zOqXgRD5Xhr1Z5ju10G4w4q1XY07GdP9bbWJmHQxQB
         svSCEKqEx3JG/jClJc021EJEO2KYoeJt5ZAsjevjGQjPe4qyhrrhGGrV0Mcl0MzVYH
         LWLqjNPxViHltclQoQ9W5cKMZlr/GK7WPiSVmqLIWC5GN92o/nXCN32zTJcqPY3KD7
         Wc3p7j2CrgKRA==
Message-ID: <eabc9cf8-ade1-ca26-8386-52fb97bd04f7@kernel.org>
Date:   Sun, 16 Apr 2023 09:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/6] dt-bindings: iio: st-sensors: Add LSM303D
 accelerometer+magnetometer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marius Hoch <mail@mariushoch.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20230413024013.450165-1-mail@mariushoch.de>
 <20230413024013.450165-7-mail@mariushoch.de>
 <501892f8-cad3-d1c7-7d24-6226eefe7edd@kernel.org>
 <20230415175104.3f8f4e09@jic23-huawei>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230415175104.3f8f4e09@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 18:51, Jonathan Cameron wrote:
> On Thu, 13 Apr 2023 10:07:04 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 13/04/2023 04:40, Marius Hoch wrote:
>>> Same as the lsm9ds0, except that the lsm303d doesn't
>>> feature a gyroscope.
>>>
>>> Signed-off-by: Marius Hoch <mail@mariushoch.de>  
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
> 
> Just to avoid any confusion.  Point here is that the dt-binding
> maintainers and list should be cc'd on series that touch bindings.
> 

Maybe not only there, maybe more people were missed.

Best regards,
Krzysztof

