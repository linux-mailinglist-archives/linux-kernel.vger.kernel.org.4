Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB36A903B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 05:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCCEYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 23:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCCEX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 23:23:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B38A62;
        Thu,  2 Mar 2023 20:23:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cy23so5393290edb.12;
        Thu, 02 Mar 2023 20:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677817436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWkAmOKELsdSC5Yfx7mlEFbvroVnh9MD92zickJKhrU=;
        b=q6VtJ7hBD+VeIdeQaEj93deAuE8Zv2a44nGDMXnxjQsGkxx0zyqIAc78Avmi5FP7KH
         RJ2AivfywfSkAhV7WVOSyVMT0pywE0Em67G1VGxcY0brMvx2c07jKzB1eyKNWO2FrOth
         kcUu+i4YJnMO/5e8eOPARnNks+GDuRcVDNYiRouUb1XrADBG67YuUg5/kEedAooog+St
         JX70vPQdvYtXVD87gLUe2Twovfkf1xvIe4L1INE5BxLfUuI3SqKGBDM2EkLh8kGV3mIh
         pqIad2iY7kZNnJt8sdMxOjJjOhBgDjYvEpK5unBUh1VN/HW3PK/ww0agDM9uftTRlRNX
         mtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677817436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWkAmOKELsdSC5Yfx7mlEFbvroVnh9MD92zickJKhrU=;
        b=Wf8+OJQSs/WdVvP4GIgCWvLSKMW9icmlrqp92x+2jPxnyJuJIIMU+gpfKZYKRZsdtc
         K6osvlnveoT7+yGnULFPurNGtv3vhKPmo4XpstLlbhY/U653egdmvXIFLpBYIvHkjezk
         VmphMxXFew3fAq54BSp7TPr0ezt1bHTVw0dBM+BsNtdHBg3Qbddn+O2TSkGKom0lGEbu
         y9Qlz1dD1dDvNTTVlWpUquAuzL0W5u/RTKtKyXkqLcXxUpkVv+KMB5fJ+Vnbrjp7AQ0Q
         C18WMpptjr1itBKJbDF10MyiOJOfSvKw1kwF6jsAdZT47YZe2HvYlByRTIP5cq/o37jd
         9wcg==
X-Gm-Message-State: AO0yUKUw1nmqblR9Gr5uYhR3ZC/zFiEFqxfl0wX91+hXMom6Q+OiNJWb
        upNkrMW0KiPjmaiYNzDi9leeV6pIKeQ=
X-Google-Smtp-Source: AK7set/URveLo9HNdChSIa0VqVy3GmW3mAMbrne9qtlVcT5+N6O431WX404mDOEVlRIjvpOz0vY20Q==
X-Received: by 2002:aa7:d68f:0:b0:4ae:eab6:a07b with SMTP id d15-20020aa7d68f000000b004aeeab6a07bmr240790edr.16.1677817435987;
        Thu, 02 Mar 2023 20:23:55 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i18-20020a50d752000000b004accf3a63cbsm646509edj.68.2023.03.02.20.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 20:23:55 -0800 (PST)
Date:   Fri, 3 Mar 2023 07:23:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH v2] s390/zcrypt: remove unnecessary (void*) conversions
Message-ID: <ZAF2WA5pDQYFjwtm@kadam>
References: <20230223011212.13045-1-yuzhe@nfschina.com>
 <20230303013250.3058-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303013250.3058-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:32:50AM +0800, Yu Zhe wrote:
> @@ -1157,7 +1155,7 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
>  				      struct ap_message *ap_msg)
>  {
>  	int rc;
> -	struct response_type *rtype = (struct response_type *)(ap_msg->private);
> +	struct response_type *rtype = (ap_msg->private);

If you're going to do this the get rid of the parentheses as well:

	struct response_type *rtype = ap_msg->private;

Same in other places.

regards,
dan carpenter

