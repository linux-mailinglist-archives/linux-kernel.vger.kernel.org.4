Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947626C117F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCTMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCTMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:08:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E5F20D38
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:08:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id iw17so1991144wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1679314103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DX4qBiGcGPtOV8eO23GpfgYZaEoud4OZh0owe5T4Xc=;
        b=ob0cCOvHCgx+sWCZcQWup1xlVWDWoiFVDCN3lJ5IhUATuzhYyZIUey29e8g18Js2WI
         g41ZkxBkZni+Bdb+IrhCVneXhRxHfRPkXKCCFNB0DVSs6duRKr1ngXfmHVvIfzsXBG1L
         6VU/SrBQnPlHWS24n4AjmKzpUaky/lmrXXDkwQDJ5CT2Db8wZ/3utkVonf8uZWZofizx
         pUNfNYcIeCZ/bwQx2NGnc/dWUqnl1sjZsTNSU3nPldjC45GW4uDUalitIiq4wK9hfS/E
         M9XhTCFkT06Tzwi1eYzBNDe11812UszSD2W/mwlqxbJO0j8belRghMoYiAiDPCQW1wiD
         pxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679314103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DX4qBiGcGPtOV8eO23GpfgYZaEoud4OZh0owe5T4Xc=;
        b=eGIbnGJUMO6VhgRlNV/HK8hUo/MQY7zDbtyiZBP1I3S8DxS6212fuv3cV2enbKadzc
         E8jRMSvZbiadPIwRN58y3qKaKRSGKR94wNpcmsBzIqNVSy+sCyzrJpZvW0Jmxh+ngakP
         bb4GBWYSOs4LMUQLlGuMaMmzAlTIr2xMBf6lt7n8/Ptp9Qk5HcZR1YE0HgivvOqpZCK4
         2a/M+A8ZCFesmdaskUIO/AYnxls33vLtmkUsoOFx4ZT4Z6XPtMgnLSKIRS+36MpvVfox
         vBB46SpnLE0+bbEzotFaJj3YsAAihmspILZI9GUOerpW1AotIW1nb2sgs+9N1t/CkuCy
         qWhw==
X-Gm-Message-State: AO0yUKUJPcbAOgO80g1OURhRYdv+sSzi6pye3zsqbhus/lVXCiCHgjQC
        OZh7epDb2RepywoKfQZjZsh5XA==
X-Google-Smtp-Source: AK7set9zj56CK4RoYFMbxlpgRSHefoSnagjvKRQ+Bu/IgqPh9O6mCqTZ5j3rbxvhvYdQvXNtJGM9mg==
X-Received: by 2002:a05:600c:4510:b0:3dc:4fd7:31f7 with SMTP id t16-20020a05600c451000b003dc4fd731f7mr31077298wmo.41.1679314102839;
        Mon, 20 Mar 2023 05:08:22 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b003e22508a343sm10251629wmr.12.2023.03.20.05.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:08:22 -0700 (PDT)
Message-ID: <a4ce2c34-eabe-a11f-682a-4cecf6c3462b@blackwall.org>
Date:   Mon, 20 Mar 2023 14:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Multicast: handling of STA disconnect
To:     Ujjal Roy <royujjal@gmail.com>, roopa@nvidia.com,
        nikolay@nvidia.com
Cc:     netdev@vger.kernel.org, Kernel <linux-kernel@vger.kernel.org>,
        bridge@lists.linux-foundation.org
References: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
Content-Language: en-US
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 13:45, Ujjal Roy wrote:
> Hi Nikolay,
> 
> I have some query on multicast. When streams running on an STA and STA
> disconnected due to some reason. So, until the MDB is timed out the
> stream will be forwarded to the port and in turn to the driver and
> dropps there as no such STA.
> 
> So, is the multicast_eht handling this scenario to take any action
> immediately? If not, can we do this to take quick action to reduce
> overhead of memory and driver?
> 
> I have an idea on this. Can we mark this port group (MDB entry) as
> INACTIVE from the WiFi disconnect event and skip forwarding the stream
> to this port in br_multicast_flood by applying the check? I can share
> the patch on this.
> 
> Thanks,
> UjjaL Roy

Hi,
Fast leave and EHT (as that's v3's fast leave version) are about quickly converging when
a leave is received (e.g. when there are no listeners to quickly remove the mdb). They
don't deal with interface states (IIUC). Why don't you just flush the port's mdb entries
on disconnect? That would stop fwding.

Cheers,
 Nik


