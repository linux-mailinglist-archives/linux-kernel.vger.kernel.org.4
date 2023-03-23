Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552096C6642
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCWLNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCWLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:13:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25A2FCD8;
        Thu, 23 Mar 2023 04:12:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s13so955196wmr.4;
        Thu, 23 Mar 2023 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679569975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qpfZTPJJNZ6YWWxO7OeWZ3NH5KTgBIS9+5dacP3FWg=;
        b=YrP/SwSi1KDyu4anm2RIzRXwB/PJOt1ZRI432CCJndwyn8ttO58mfXFdZ/kQxA13tF
         wuOgauK0t5tpBvCpPWsNXDaKxeF72posCIgjx25c9t13wrCfkx4H8nLaB01RMKIKTcnc
         6I/9DS0LqJMmTzQ0T3xoV1FVLZKmSvA1eJhi+cmSFIdqMj+pEgV3CPYlCE3WuE7wkhtU
         9vsehtUPYVe8bKrmzTF0Vf6ao8VLurI9sfe5uIUOzd93rEFMzgUWfphhfxrNaiuqdYg3
         0Aab60ij1EOpyXvtxuadneFWPTg4mAIH9+Tpw5hlZzssiA/Gp7njFORKtF6X0FRhog8X
         a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679569975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qpfZTPJJNZ6YWWxO7OeWZ3NH5KTgBIS9+5dacP3FWg=;
        b=NFU+6Nq5nvw+KSaYN5/8a321XEignNQtBLhcNDOIm6jeCNse29425q8QouK/efphJf
         T1OXEHSW/Z7vtZSVX9R77e/XxO/DQVwPPANcyDXvfcY4mA6J/nkYYEnEbrT4dJf2ACDg
         bJW9pvxBZWFJUHIwmmtq4jKipDgjwM8acininZpwryUsYGfGm+4OGayKynvTHfU7YVcs
         B6KEa8nGWhehn7TmhB28mXajCdiLmK4mWzdqJxJIq8VFFqe7iCD/k22qils7DFsDYQtu
         AgJLrwpSYzgsUSGdBgmnLQsncLH/o3s7ZMd/P4YFpV8HJwD74fcsZeslFW7gTcHniSDb
         rK1A==
X-Gm-Message-State: AO0yUKXinIPAmekW8Zd9SAoR7OyklH19MEJu5Nct1uIl/yTMcmPYz0B/
        Xss4NdYrQAuDEMvalUrPP3A=
X-Google-Smtp-Source: AK7set9ymCWKGYagcYxXc0qjDuuAzVL/YXlz6Q3Wo2xGJPyRfMMNzoWGb6UOFWPwupDfm0FMQVkonQ==
X-Received: by 2002:a7b:c853:0:b0:3dc:4042:5c21 with SMTP id c19-20020a7bc853000000b003dc40425c21mr1990952wml.6.1679569974878;
        Thu, 23 Mar 2023 04:12:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003ede6540190sm1693390wmq.0.2023.03.23.04.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:12:54 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:12:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <42a2ef2e-b522-40c9-ada2-0e804f7df5d5@kili.mountain>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <eedbfdca-0eb1-4b01-976b-4ddba516cfad@kili.mountain>
 <e2067012-af9a-4cc7-ba12-3c055d54d915@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2067012-af9a-4cc7-ba12-3c055d54d915@kili.mountain>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:00:35PM +0300, Dan Carpenter wrote:
>  	irq = platform_get_irq(dwc3_pdev, 0);
>  	if (irq > 0) {
>  		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
> -		goto out;
> +		return irq;
>  	}
>  
> -	if (!irq)
> -		irq = -EINVAL;
> -
> -out:
> -	return irq;
> +	return -ENODEV;

Oh wait.  We actually need to propagate the error code here because of
-EPROBE_DEFER so my patch introduces a bug.

regards,
dan carpenter

