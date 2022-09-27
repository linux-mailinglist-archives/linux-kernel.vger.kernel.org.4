Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A05EBD13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiI0ITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiI0ITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:19:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2AB481;
        Tue, 27 Sep 2022 01:19:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so9430361pjl.0;
        Tue, 27 Sep 2022 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9U+Qwke6i9i5veqMmKRkGRTk17ZxOAfJ107jvmytI2o=;
        b=Rx4P8Knj0NPbKfAvw12ndhmhaR87tzsHAoBOw9QlJzGjGqNh3l7v8odLyRgz/u0vjS
         segkGFeEMhFXlSuYalUYD/xkSztwdAfLDqP64F/ScjeRh1q7Tqdz6mt3uKsQgpoHsLV4
         +AncxOntrmIbac9hDreTgYXtD8RxmL5+04Z25IiP8qG8GRHX6bay/oZaMo7IZooXu8aG
         J/hVqxE2xatkdQsfH1AHxPDr4HDiF3rq2uMnhQgj/FuN1NVc4tu6E5lCzZx6SsqljwNh
         I1sxBmoYPyWFTSjTvhvhshLbtKlouY5TzZI40tSobpU+YfQjY9mZxqJYdsei7eQ6wZ+u
         wuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9U+Qwke6i9i5veqMmKRkGRTk17ZxOAfJ107jvmytI2o=;
        b=mFtIASolk3PlKehUGwSaswL0G19KCIjRU2/wAZlw+c+Swh4PR1syjs9QQN65I3eGfU
         M1MvWhwIYPdtwLGeJlNrVHXwY30PKcHaXT8gY7mnOEBto7M535RfDVcenpmyEyAz/hOz
         ch9oGYhU7whwSkmCOwI0Duc2/3G/+HAZCGnBuu6G+W+Y8oNKOHU/B/2NsNd59ayLEQtJ
         Rc7YaN0hGnWwK24tKPtdOHcOREAqbom2W1KDiSCuBAJPRxd0p8tPvTxd7EfHKtVVbgqJ
         S9x0vmI95R4s6iKrzFC+mJ0n0FXnrajvjNVbvQ/Ibt2f8NtkJlrFWd5AeHvMtiDVv3z8
         mXtg==
X-Gm-Message-State: ACrzQf22/xewddjP3967kbGlu8Ik1Ze0ncH8SXY2Im7QCBvdMow4WaHr
        ziSyBeHbN8+oZrukr0jT+diqaOZD7Gs=
X-Google-Smtp-Source: AMsMyM4hRHa0SrXblfbSs1dZTPP/1dvW/D+2EVB0KBZkQIgccgRP6GIZaG7Zbc5VjcXz4jTvLD52kA==
X-Received: by 2002:a17:90b:4a85:b0:202:4f3f:1f65 with SMTP id lp5-20020a17090b4a8500b002024f3f1f65mr3181331pjb.241.1664266773606;
        Tue, 27 Sep 2022 01:19:33 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b0017849a2b56asm870691plb.46.2022.09.27.01.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:19:32 -0700 (PDT)
Message-ID: <dd89a30e-5403-8844-036c-9c9107cac888@gmail.com>
Date:   Tue, 27 Sep 2022 15:19:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation and
 practices
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220926211149.2278214-1-kristen@linux.intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220926211149.2278214-1-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 04:11, Kristen Carlson Accardi wrote:
> The Code of Conduct interpretation does not reflect the current
> practices of the CoC committee or the TAB. Update the documentation
> to remove references to initial committees and boot strap periods
> since it is past that time, and note that the this document
> does serve as the documentation for the CoC committee processes.
> 

When was the bootstrap period be concluded?

-- 
An old man doll... just what I always wanted! - Clara
