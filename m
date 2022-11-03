Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DEC6173EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKCB6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCB6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:58:32 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B990511A13
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:58:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-36cbcda2157so2986527b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6gpw50arjJAJYutxnBYI251PZ1iO12jHMUjWqVshAjU=;
        b=l/lMpWK59/mxYJ0uzKcU1dwz/zghIOABVMyxZ8dBz0PvXENwxIc1caZMnVDN5ph9OL
         Eett7V1ZXGZ4tt1jmwMIkeSinZcSOGpwq31OPdu3yRYj29Cz73XCd0540pdiGY8CZQgS
         P2xRNyFOnGJQ1QzaMe+vLYPJdNauK0bVde5tTvaJZAy+VbZtJqdNHmqLelj7JNv4WW4Y
         r5qqqwu04bee2qvRcOoaJ9sVMrhBdnkrJ2d+k11qP5R6ToiMqAInQ2k9lOX33TFwTuEB
         CgSCCUlcNq5BprXVI0Ykn0oIyYUBxzZZtE9w/oY2D1i5W7h5j5dvnM0aDdzip/nQ+rFw
         2uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gpw50arjJAJYutxnBYI251PZ1iO12jHMUjWqVshAjU=;
        b=C4EHMNYHlff06m/b9ulBoQQkrymU+S1XSoWxCzhDICGcl5yaoi68PXCGmqFOstOnHZ
         Ic38MxEw9Mk4JuXUL7X72iTowyiMetZqCliSeWmCY2rpHmS9uJS3m9VjJ2OpTzWCx3am
         Lr7cpZ5qDfMXIlDn7SY/9TdSrtXcgxh5ZurS7zgaen9Nt91fRaR+J5DHbFhff5m+FZpd
         4hu8sinsfE2CYQuamIf1uvFCLMoRmSEYWEK4Fp+89XpX1mteDghSHCtTGsK7GWhWc5cD
         UEvGPBlOWcntbq80Psv3oCcwF32GbqFHgZZs6cILk1rlYYEbJp2Xe94cBKC9LzHNyopg
         YqXA==
X-Gm-Message-State: ACrzQf2dXt11b33C/QfgFhjhp0iBhfSJ5EjUJI9Vqe+yuymLQr2PBA/Q
        WsNXqAP2cYzd/uqLyEDI+XvNQjwApJums4pKsqs=
X-Google-Smtp-Source: AMsMyM4rR7xGUPShqh2e7n+4JTDWZX+l3kUKR6tTSUNwQ31Tded+dOHWuLN63vjUIjFLm1DF5tsGJn5L1zBRlD/ZyO4=
X-Received: by 2002:a81:895:0:b0:36b:fa9a:beef with SMTP id
 143-20020a810895000000b0036bfa9abeefmr25920523ywi.310.1667440709000; Wed, 02
 Nov 2022 18:58:29 -0700 (PDT)
MIME-Version: 1.0
From:   Nogay Adygman <nogay.adyge@gmail.com>
Date:   Thu, 3 Nov 2022 04:58:19 +0300
Message-ID: <CAFUOiQbsyMMmLNkA8p_jPYVZHfnZ6feoAO1TMfcCvYA3JSNBdw@mail.gmail.com>
Subject: rasist - kandidat (+history material)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://de.wikipedia.org/wiki/Alexei_Anatoljewitsch_Nawalny

(+ no work link
http://lezgi-yar.ru/news/navalnyj_razreshit_gej_parady_i_zapretit_lezginku_esli_stanet_mehrom/2013-08-24-1620)

https://flnka.ru/digest-analytics/5673-kto-podstavil-kreml.html

aborigen nogai
https://www.interfax-russia.ru/south-and-north-caucasus/news/vostochnye-rayony-stavropolya-nuzhdayutsya-v-pritoke-naseleniya-v-tom-chisle-za-schet-ukrainskih-bezhencev-senator

interes monument
http://zapravakbr.com/index.php/analitik/1498-madina-khakuasheva-chto-skryvayut-geroicheskie-pamyatniki
