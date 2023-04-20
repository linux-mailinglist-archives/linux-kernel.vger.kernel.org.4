Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D16E8852
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjDTC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjDTC6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:58:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05D41FD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:58:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso141110f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681959528; x=1684551528;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVjQAYMnHOmsA2ZnYL2we7i3OnaLo+6zRvLr1nG8cvg=;
        b=C3nZK6lBvrBsAWe3g7iFQxWdpjPpUKbugFb19PLZ01MPYnU1x4uiRjnRbJ/BXesO02
         OTsNQWk2199hVB9rBMd+SioihUEZCat5++PFP/TcQGLXjt2VcXCmNZBHyAF6IfsAwuei
         TpJ2s5sh4cZfmexnSVVkV8rwUPIdwtZ4l+TarpUOqreTxPElw6kQ155MmDg/zxuknaCC
         9eobY14B7ahGcBJQooIjiUUKGEu6rZ22HE84E1+OxDJbEVldCb+yqDFhvdOmnaeR4r2w
         CxtqlOX7TS5Q6WzaoDVtTzrOt91XuJCVIP/dFCSnrJv62/8rigkdgcQG35xtCuMpo1bk
         /0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681959528; x=1684551528;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVjQAYMnHOmsA2ZnYL2we7i3OnaLo+6zRvLr1nG8cvg=;
        b=dgJUYLICdLOX2W3fKHPYKvtUMSVBhQczwIG3lOPBush7HZ6zThFmHa6c9YSDtX8OEU
         Dyo/ADzowSq+XMxl7MGeKJbDBuZjT6vyAh2obDwu4gy4ReoPHiw7nNiung2OAudrEsFl
         JyzO65LtNZd8+6fpLKmKBlaQM2K6aoUI5D9BWxzWTfV2cQuAFQwonmUV2Dbvdn+NZi7s
         ks1XteLMZGNU7S1/iC/sIvUNrTt85mL67aUJoef5/d2qlAY7p/dPpsGV2aE9WvquZdj/
         rcDCLgHyxBty0eqMVYjD6JqUKSamFV2+mc646ELFFHLRBpri80tB3MU6CfgoDSSb16BJ
         LoKw==
X-Gm-Message-State: AAQBX9f04dNwB3deSD/H5dgk1/dggWgD4x9K4fE/a6IUzw6wONOzk8KF
        seJmkSMAE2xD8J3HL6kuSFEghzAk83g=
X-Google-Smtp-Source: AKy350Z1OMiViaqL7ISzsDbGiWUDodQLsNYWYt6ibcqHh2Q3oXvuapDGaB5/23VI51h0q7xk9Y+81Q==
X-Received: by 2002:a5d:6a11:0:b0:2cb:2775:6e6 with SMTP id m17-20020a5d6a11000000b002cb277506e6mr6224033wru.45.1681959528362;
        Wed, 19 Apr 2023 19:58:48 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd? ([2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd])
        by smtp.gmail.com with ESMTPSA id z26-20020a7bc7da000000b003ef5bb63f13sm3825601wmk.10.2023.04.19.19.58.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 19:58:48 -0700 (PDT)
Message-ID: <8de1912e-8009-3c85-ece5-7ca7f03be42a@gmail.com>
Date:   Thu, 20 Apr 2023 03:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>
Subject: strings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

greeting...if youre interessed in string algorihtm check

https://andrealbergaria.github.io/


thanks in advnace


andre

