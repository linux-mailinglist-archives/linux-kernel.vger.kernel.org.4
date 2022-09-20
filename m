Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BA5BE811
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiITOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiITOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:07:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAEC2DF5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:07:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lh5so6393314ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=kqLLtRRtX2va0/fIHLBexwWLBeltsD+YA5Ujg84gRVU=;
        b=NUPDnqRJ6WW9+SVUQuXe1w1osplmTp535/KAbc1WC2oOcSFelHto20nv4dLaOPx7tm
         0pC6rZIy5zR9Xd07FqFMh/JF4JpZzqVe62fKGn1MAkFKkbVbuLVerVlGkueyYAmjhQJu
         tGkx27iqEZyNEAmJz4D5uYYiyffjwYvwpYZpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=kqLLtRRtX2va0/fIHLBexwWLBeltsD+YA5Ujg84gRVU=;
        b=mBNH+BO4pEsm17er4WM8fMM8/xXLmewWf+l5TYf49zM4kpbHxLWQ9qVIK3HGj8OT1o
         AIkMQu2oTUIX24/Jw5MqIgoaVnmCn8ZIRCZ3KxPeClDSfn+Vv7mxBK8gfQLqXRmhGzqh
         lD9IZy/4X4S98VWUFqV3LSAA2owGoeO2t3QqbJ/ze369RnzqkLTTf7l2jP851PEUqBR1
         aykGAWT5U0hTHvtlHWf0BuP3USYqnmsRpXWlZoMdj3fmbMVOkhDWeSpb4pyenO+054Pn
         UI400upijn+MoEKYo8vGsfHI4eny1bG84CoHAvxU916ystlfhyO+W96kkPsVv/PTngEg
         yU3Q==
X-Gm-Message-State: ACrzQf3LlEwWWc/id1bVsntRY+EmlvRvVEA9KtPXcskWJMu6NzP+vXM1
        k3qjjI+N9oxgyV+T+yQwtYG0Tw==
X-Google-Smtp-Source: AMsMyM5YVxtBPm9YuU7HiquvoRrRiQkXLWVPSFK+aUJ/z/3m8XMcPEQ6zahOjnEvRBfIpXBrbLLblQ==
X-Received: by 2002:a17:906:db02:b0:780:24e:cf9 with SMTP id xj2-20020a170906db0200b00780024e0cf9mr17211851ejb.460.1663682849027;
        Tue, 20 Sep 2022 07:07:29 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906308c00b0074182109623sm902003ejv.39.2022.09.20.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:07:28 -0700 (PDT)
Subject: [PATCH v1 0/1] [RESEND] Recover stalled ElGato devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABfJKWMC/w3LwQqAIAwA0F+JnRvYKLD+ZuZIQSa46iL9ex7f4XUwaVkMjqlDkzdbrjqwzBOcif
 USzHEYyBG5nRw2MdGIUi6+K7Jft9VTiNERjBPYBENjPdNY+pTyfT8oZwlxZAAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:07:19 +0200
Message-Id: <20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=632; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Jj7HLVfKhkZv0osWCyMWN8zSact6ocK5803gqNWH6Us=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKckdYES5Y/7YxolA+GmRp48DOxCaNNF44eU3fYSw
 mejdmdOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJHQAKCRDRN9E+zzrEiBStD/
 46sobZ8KYZOqarRbxFYxZJQexxDePQagXvcECbRszRL0sqEejIpo8Z9npOTKKPYHEesPqxHl4l3goJ
 7qxlfllMRgkgR6vd9phFxkmIFE4RduJh3ldx57ykW1XjrTHvXZTeN7tMgxMFsNB0x2OMEMImCnfMci
 JkYMwYZfpCEcVHGBHtjfjYDgiJPqWetpPj8fhsiPd3mh1MRw/daxXuS4iZmhXIJRqsYFCK4OM1Mkf0
 +873zr2yqOkbRBJ85hV+iCAFt/dCACl0jMSInAmMNgkX/poVdUe2w+f79vNz85MLQWEgCarxDj/Dcm
 ETtQPtI6nH23FqZOu9Qdz7Scj0hzHphsPCapr9AfXuCaJM7L+dHZfzRjaHUscoMCWowh5a84aGXnUx
 NnCfQ2AubFCwWGvEE0G5a48pIb5/AkvxuP0WWMrb6uEGGbsImJpVy7MGrLyppnq5yYytoHRPmbh8zx
 uOs5KZkv543r07XnLLtkFpDyBRkgIYnfw/ksrycUW3OrWwhsDKbq/AdPT0+eNVFdpC2iFLWJJzrby6
 uaK6fDlc6dr32ESvf5vbGpNZJQHJHSjSMcO0S/4KVvJxAGDe6JWUQcPYRGvK0VN/Ed1nk1YPOlVHNU
 bICw8onNcc8b9uf3js2Q7Gb/k9oWhCknXSoDwpTwstgITXAEnoxAvKWculeg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a resend of this hw fix.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      media: uvcvideo: Recover stalled ElGato devices

 drivers/media/usb/uvc/uvc_video.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-elgato-a845482bdd02

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
