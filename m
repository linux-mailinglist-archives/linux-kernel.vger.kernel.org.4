Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648206D89C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDEVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDEVsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:48:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A327A95
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:48:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-947f54f67acso7582266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731308; x=1683323308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wb89At04Bi8wiMaKMj24IvEwgTW885oVxHw3HIZ4Q3w=;
        b=Bw6jtK5qklfy9o5CDcreSbZVT5HtivXxGQm+0wZ8DiE2RXDKk5W6xzuicOPKOnqBBL
         SRCLjTy1jl1NpzK8c0/ldtJAUnQ9iCwz5G66mKPFN/KPxnuri6vV+lam6cHaYFYFNgiK
         2p1nW36YI654ZRvK2x4dJUU2z/tOPF8V5f+ZdxtKrqdR72aS0NlmpKo5hhitBmCB0r0j
         njaQIsS2i/0uEI+0fGyF33J6cOsSQfVzSBUl8wWxADCdwKPpTwJU5BiAzN3TwUk09/Mp
         +/tMyuF0B88HwXwBBQR/I/9JjCczmcQnwZJH4OIBjbQFvuKyVTl3CBcBIYTz+JC69oHb
         rArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731308; x=1683323308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb89At04Bi8wiMaKMj24IvEwgTW885oVxHw3HIZ4Q3w=;
        b=nT/qbuWa9+BmZqpwt78cFOi+2EBScCDHVed0U6uGWVWfMlR3V0JFm287CH+DpkmAll
         OzquG12oXtqvoZYob9VGjXi4xBf4LsqT8CGMAx1YwBW7rI2yPNz/nXylEUa8neGBBaQ7
         boDqgmyR70jIHNbecxSklCEHDKEB+U/1XL2OvEcCGYyctG7ahza90ybXG1SsdwEeb1MO
         /N4bVbXyMy7eoizSIEnuNermO7xmSagX6rQmmbKvZuWyoxsDo4L+idrQoaCHpodmkjB3
         vXPEk3KPtJHG9BfGwMe+EY68TbXxm6n7iO4ff49InAwli2/x0MvkTJUXvcjV4nmd/lPJ
         aUAw==
X-Gm-Message-State: AAQBX9f6j+Xa8R+hM65VRZn3zyovOH/qj6n1DSebMIgl/E1IHonYMcTU
        zEtW6cbkGwiisJm8HDy5y18=
X-Google-Smtp-Source: AKy350bJ561AvTuxSKMXRcqLa+FNL2FUuCCD2f3n8tmaWku8oXRbzr3vL1FXz3q2fgEDAmzf85PLmw==
X-Received: by 2002:a17:906:2093:b0:933:2e79:4632 with SMTP id 19-20020a170906209300b009332e794632mr3098433ejq.1.1680731308443;
        Wed, 05 Apr 2023 14:48:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y1-20020a170906518100b008c76facbbf7sm7984053ejk.171.2023.04.05.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:48:27 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:48:26 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: rtl8192e: Remove unused variable RF_Type
Message-ID: <bb038a5ffe3208f385543d9e7b360bd7f2f05d0f.1680729716.git.philipp.g.hortmann@gmail.com>
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable RF_Type.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7d83a4c322cf..ae7c6a5804ee 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1390,7 +1390,6 @@ struct rtllib_device {
 	size_t assocreq_ies_len, assocresp_ies_len;
 
 	bool	bForcedBgMode;
-	u8 RF_Type;
 
 	u8 hwsec_active;
 	bool is_silent_reset;
-- 
2.40.0

