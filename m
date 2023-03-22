Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCE6C4AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCVMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCVMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:46:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC63B221
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:46:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so72435065edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679489158;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXeMKtIKHjsg7Op7j6slpwd6r2mcaZttOICdsCewQXQ=;
        b=VDVv8Ntl5vSXVCENxo4q8NI4/UjIJGJQ00WyQ6x1CasZpbnGm3Mj9f9OpBsVFW1etq
         t7ZtTzsC07hkcaqe/BPPaVSij0e8JQ/OrUAe0gv98hQ7l6YRX1csRURqUsE+T9szm+5X
         vL76xlxMcOk62ckyyaC+bmE/gmAPdjS1WY0L+F3nvgPj3Kb7eumynfV1e3ATK/k7KQe9
         luY1Jd6NeJRF8VTWj8wkvehrJxAxA83u5cgxRoqopxqDsRclqgDCnFliDAZo6z7VyOdr
         9okSaTfuIxd5RsJAolcBlXHcVdCk5tkL8YfFkUvHKQsi3IuSIOtzQM3/SeSHqFT+z37C
         qT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489158;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXeMKtIKHjsg7Op7j6slpwd6r2mcaZttOICdsCewQXQ=;
        b=JmJ08dp5c6VdDuWFGFq7GN5dgF3e8VdLgVFq44Gq6s3V6jG+pBqsbSENGHJBDi6GPx
         3iPNqwV4TPKL2HLjzu6iHubc5Q0INiCEl/y7d9yNru6VnaglnMc2FgnTd45VTyJs2SaG
         M43kl3wbsNFBvcU9tsnG7hrp2nDhm/aQH1OrSnmzn4U/phgUkeH2GZ1GOvZWV4EDYZ+2
         EGoAdTFjMcnvX0B8rrp2aQJ+Va3rMVirvV2+V2TZuh0kHetL9G0g9NYA3NjVc42vXkKe
         WNO3pzwIkOnwlwjG/rMgv1viHR9kZT3qte86HWQrk1emFptf+ccDMPNsgpsgaWascTRS
         AoiA==
X-Gm-Message-State: AO0yUKUsbs6p9wv+lg44RI5HlBlm5R9i2lYZMVW6wIxVCpWos+IGxw7V
        EQhwNwS7w4C/jFpFpGOxBeckuFEPokGx5Y7RQwY=
X-Google-Smtp-Source: AK7set+TyiFVN3suONv63xJHiSKwqlJSRl9LhXSxpQE59bwgFkCAnl/Mcl1XY6DxcNXAP2NNNgeQtnJF6B5kkuyzxGU=
X-Received: by 2002:a17:907:784:b0:92f:b348:8f93 with SMTP id
 xd4-20020a170907078400b0092fb3488f93mr3292056ejb.10.1679489158497; Wed, 22
 Mar 2023 05:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:13d3:b0:64:9cf5:1560 with HTTP; Wed, 22 Mar 2023
 05:45:58 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <angelacoulibaly5@gmail.com>
Date:   Wed, 22 Mar 2023 05:45:58 -0700
Message-ID: <CAHipQu56qs2A3ivSejAbv6VmVcp4JVq9KKfe3bv_176i_eje9w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
 Hi, Please with honesty  did you receive my last message i sent to you?
