Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98176B0058
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCHH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCHH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:59:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0195E11
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:59:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso580131wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678262354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=src9kyzL2qKyLwD+KhZmySOAfWQnjiEOGoaEH2ByILM=;
        b=mipK7iDSwS3Yxvso9vbyyVK87puLNOTY0XWzkQiXu3dhJUKraOMdSgoksS+Azef9Dk
         3czr8KqIKEL803WTJlEuIJw8EvSLb23zhK1zwdpfVcc3QsX/AEnl5+D4mSYEEyKs3yyQ
         JBDdeOS70o+V6ji9oiNa8bKsEx3o7SIfFlPdNM2DKeN8dva00LHxAiTbL3YQnsbmU7E1
         PhPM/VVV/BzeHn+dAkj5ajnvhAZDl9xGTTpnbCBpT62O5/CDS9nPtbbjlhoyJs6zfI4s
         4q3UjI+DYrQUfWojQjQcyE/o/zGFs1YRHcpDPCm5sbwMApXImJrv7Gnh0C9f3FXUnAoc
         mBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=src9kyzL2qKyLwD+KhZmySOAfWQnjiEOGoaEH2ByILM=;
        b=n8coMl2UDWXh4EknuxzVfXkiSRUIAA6IsMLzYpBE5HSCgsLO5CVshRF8dc3Bed7ZOI
         3A7SV+vOySy6SQmtJVsqNMbWm8HEOV6kU92gPBEYnRNro5oVErKCtdX6xs27kDkT6aKe
         eoGwCwji6IJmixVUkwyiUsNTh4RmHtqdiG1cQR0zuk6rv+6Wk+hsmDrdHNgAJdCL6PVC
         Z3/AllhRBPZqxF/9JzqbQ/TQIAcWUXwMyyZOKx2JpZ4VGurAgaICdKQRbZGEihvxaaD+
         QWXrRB7OtAQJtEn5biXo/LvuGA1U6dDZUsJFMEolTobrau2yn9cz6VSpKhSlZBwL/1PI
         a7Kg==
X-Gm-Message-State: AO0yUKVwppALo6ea6OQ437KJyFWL776T+J940cMa5VZDwwSb0CaYNSZD
        DccXjApVVmkMlVzLd97sHTbKc98VBUA=
X-Google-Smtp-Source: AK7set9qO6D7y2qLGArvOc0L/cMGzSa2wGhmgeDZxxVJX/mOQoz+kQpzUlZmSgtQZU+rLBlhh4YPhQ==
X-Received: by 2002:a05:600c:6001:b0:3df:9858:c032 with SMTP id az1-20020a05600c600100b003df9858c032mr14204830wmb.7.1678262354117;
        Tue, 07 Mar 2023 23:59:14 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003e203681b26sm14510248wmo.29.2023.03.07.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:59:13 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:59:10 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: rtl8192e: Remove unused Array
 Rtl8192PciERadioD_Array
Message-ID: <66c038a7-3447-465c-88a6-ccef10c149e1@kili.mountain>
References: <cover.1678222487.git.philipp.g.hortmann@gmail.com>
 <608ced17b85ca321fdc0026c686e3c62a9d6d8cd.1678222487.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608ced17b85ca321fdc0026c686e3c62a9d6d8cd.1678222487.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:01:25PM +0100, Philipp Hortmann wrote:
> The array Rtl8192PciERadioD_Array is only used in function
> rtl92e_config_rf_path which is only called in function rtl92e_config_rf.
> In function rtl92e_config_rf a termination condition for the loop is set
> to priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2. The loop is only
> executed with numbers 0 and 1 for eRFPath. So the function
> rtl92e_config_rf_path is only called with eRFPath for 0 and 1 and never
> with 3 that would make the "case RF90_PATH_D:" be called. Remove
> resulting dead code.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1->V2: Changed argumentation in the description and subject

Thanks!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

