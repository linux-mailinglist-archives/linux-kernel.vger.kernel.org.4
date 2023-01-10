Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58261664545
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjAJPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjAJPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:49:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088D944C4E;
        Tue, 10 Jan 2023 07:49:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z11so18231306ede.1;
        Tue, 10 Jan 2023 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlwouCi8H0VvCFHHOlIlDVE1aSi+HO1S7gDSu150N9o=;
        b=Ls9jEEVeVOogdOhnGSIKAnC3MFbZ5Ol/YRfgadxXtNM6zGPapxkKjsK2nwhmOxs+xj
         vjeT9QnhVSm8r6ZrSlEooK2iIN3/KBHR/gLW8AipjjvOaN8m1BTOzovjHPqk6xjU1DEw
         CxjVypf7mDTyHnXhjxSxvcstWNTsevS8dN9xg402H/4Y32c98tpjmRhJT1Yl81fPQBTL
         D28TWLVKJ5KY+LQNjhN8V9/y8zNW+otaBkrWDyqtvy5xzLNFBFyitc6boUnL+lNUWC/2
         OnJolzF15hCUJhZpZ0NsGDJeHOP9ls2uJEk740kElNA4I3MMh0YOT34s1wNaH+OS+jb0
         qtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlwouCi8H0VvCFHHOlIlDVE1aSi+HO1S7gDSu150N9o=;
        b=KTdX5hvz12cZON13oS8NctfK+kS9p3B/mFmKLWtDLLbfQ1AeDGokMmZ3k7+n0mvhJd
         A1Y1CL9QYLRyWv6eQP1aJgjViu/0ZuE9LkRBP7WZtbpRzUYqkbSu+UezfWwkvKWVz5go
         Mu036yl4EhEe7XLZ/pVDW7jOkLXK2dcgE18XMPIvj1o/AHI+QLZXDgVltUTvBATWFHyT
         VSrG13PG9lZxAh+xr8ir26hHMeenYqL7+t9poSpoy9noHX2V5wUXd8IFUFpe62QBqWly
         3PRHWdIUn9+N7g4BzD1JPl6yO1ZjrerXq0ErOChXIVtmEb6ZqlNIJzebExwjwKKIhGSo
         MupA==
X-Gm-Message-State: AFqh2krgzBZNnV3ZZw2UxdTbtWxB4H0Q3mchsElLCOcWaUGrZAPd8JtY
        rk6FmtnrsH4m9z9M/nT45NI=
X-Google-Smtp-Source: AMrXdXs5bidUFyY7RUUCR9qvNSDcJGtq434/qMc8FWLJuxLNi9j9NSppDNXbg7cLU3itdPPD4+pVfA==
X-Received: by 2002:aa7:d789:0:b0:497:4f53:ee8f with SMTP id s9-20020aa7d789000000b004974f53ee8fmr12917106edq.39.1673365773324;
        Tue, 10 Jan 2023 07:49:33 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:1402:f4b6:2bd4:8c31])
        by smtp.gmail.com with ESMTPSA id cx26-20020a05640222ba00b0048ec121a52fsm5063572edb.46.2023.01.10.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:49:32 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Support Opensource <support.opensource@diasemi.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR DRIVERS
Date:   Tue, 10 Jan 2023 16:49:01 +0100
Message-Id: <20230110154901.20223-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml") converts
da9063.txt to dlg,da9063.yaml and adds a new file pattern in MAINTAINERS.
Unfortunately, the file pattern matches da90*.yaml, but the yaml file is
prefixed with dlg,da90.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Repair this file pattern in DIALOG SEMICONDUCTOR DRIVERS.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/all/20220623104456.27144-1-lukas.bulwahn@gmail.com/

v1 to resend:
 - added the Acked-by from Conor Dooley.

Lee, please pick this minor non-urgent clean-up patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a1368722c45..a0cd07e968ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5971,7 +5971,7 @@ W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
-F:	Documentation/devicetree/bindings/mfd/da90*.yaml
+F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
-- 
2.17.1

