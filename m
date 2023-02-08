Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2859968EE54
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBHL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBHL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:57:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9D48592
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:57:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ba1so12423429wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 03:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkgv51e+S+gpia9goEDyOF+wKS8a5XCd9MWj3hy4Qh8=;
        b=cyXRdaZ8m06Ue4ok4y+JiEQ69PyZ6VegToLzU/gZcbU8UM1DxPT0KDrENTWdb1wI+8
         ZTl9rwGNWkhua8qh37Ixw25uiZja+eb/rHnFIUwvqZIYsIZKmwo4sk5GKHmOzcjsqrc+
         qnQ4EhYVmxINmOGrIt3YL3Cw4HoPuwdvKwCO538Dj4ax8fzY7uyoutPTt+0tHobfrnyB
         EjlFQ799aIP6ypzx9ClpxyAFiPYRSy5Soa75uN7AASmaNdE7ilHdiwLKfORmdZQyYlSR
         QfpqWrJ3O+fWQ4fSWeyECEFE7Ld00Faf5O1VjNEI9swfXEjnme7uBZJec7l5zJjjERz+
         4pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgv51e+S+gpia9goEDyOF+wKS8a5XCd9MWj3hy4Qh8=;
        b=wSdKNf+h4fZF3wQC73zGqEFhcIsLUuhgOKA2BAVnvmq54eLeU6Q8QqZ0XqTEKvaOJi
         8sOk/kJe0jCICUS3Os9hiKKMQDZLziNIMpF0nPPVgIZDJcy7hsipbJAOWQ0jUhhMXIMx
         F42Mbtxitnv5Z1MoTbsckLQDpu0TeePstEOvd9vJ39jrfk2LzNgFcGtA0mS6INlAPiMq
         PoliYqL1hIie5TyCGjj1ynj0xLrRx6L4T1UrsWj6OXPc6D7/XNP7PHfyoI0s/GiopDd5
         6gWWJPZNE0emDkuydXWwqn/9MRi7ryGOlFEeFic0TtEUst2shP5oOSurz9vDTjqO/c2J
         uthg==
X-Gm-Message-State: AO0yUKUG/3DkZdQnXt61J/ZOcUQxTDc7OP/6w5/qU7p2+91E9pcqmmtW
        jP5bP6RHNUsVYhG/88Mx1StGhQ==
X-Google-Smtp-Source: AK7set/7wPBkCfjTlFM94tHI/xXenu6VgOEq5rCokaHvC6jxnV+xKlh1y0eNcmWGi/cGDZrHkUhdzg==
X-Received: by 2002:a5d:42cf:0:b0:2c3:efe7:607c with SMTP id t15-20020a5d42cf000000b002c3efe7607cmr6013996wrr.6.1675857431344;
        Wed, 08 Feb 2023 03:57:11 -0800 (PST)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b002c3e600d1a8sm8004744wro.95.2023.02.08.03.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 03:57:10 -0800 (PST)
Message-ID: <02e45c4e-1343-3077-2848-b5148faa2d4e@arista.com>
Date:   Wed, 8 Feb 2023 11:57:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/4] crypto/net/ipv6: sr: Switch to using crypto_pool
To:     Dan Carpenter <error27@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Bob Gilligan <gilligan@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        linux-crypto@vger.kernel.org, oe-kbuild@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <202302071833.k6CihGFl-lkp@intel.com>
Content-Language: en-US
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <202302071833.k6CihGFl-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 11:40, Dan Carpenter wrote:
> Hi Dmitry,
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov/crypto-Introduce-crypto_pool/20230119-054258
> base:   c1649ec55708ae42091a2f1bca1ab49ecd722d55
> patch link:    https://lore.kernel.org/r/20230118214111.394416-4-dima%40arista.com
> patch subject: [PATCH v4 3/4] crypto/net/ipv6: sr: Switch to using crypto_pool
> config: s390-randconfig-m041-20230206 (https://download.01.org/0day-ci/archive/20230207/202302071833.k6CihGFl-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> net/ipv6/seg6.c:539 seg6_init() warn: ignoring unreachable code.
> 
> vim +539 net/ipv6/seg6.c
> 
> 4f4853dc1c9c19 David Lebrun   2016-11-08  532  
> 915d7e5e5930b4 David Lebrun   2016-11-08  533  	pr_info("Segment Routing with IPv6\n");
> 915d7e5e5930b4 David Lebrun   2016-11-08  534  
> 915d7e5e5930b4 David Lebrun   2016-11-08  535  out:
> 915d7e5e5930b4 David Lebrun   2016-11-08  536  	return err;
> 754f6619437c57 Dmitry Safonov 2023-01-18  537  
> 46738b1317e169 David Lebrun   2016-11-15  538  #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
> d1df6fd8a1d22d David Lebrun   2017-08-05 @539  	seg6_local_exit();
> 
> Not a bug.  Just dead code.  Some people like to store dead code here
> for later, but it's not a common thing...

Thanks for the report, Dan!

-- 
          Dmitry

