Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0563673B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjASOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjASOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:14:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C7B302AA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:13:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so1231093pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=ZJqQQ/1RKVYiHEdaMQRDSMonhd5YQMJZQ+die2GV1mAuEtGcvZj8T8q4aGDGuu3Zxa
         Xkko3TBw7eMXq5CteassdBtg9kVeMJb8+XIfgHw0rnz5caYA/u0V+bnB1jbmdZTiCBua
         jsMKgVVAk78439KDdUVK/5qMSUk5lQFcWLD1477Y0QvSHDBvtaUGdyjerIP9uAaz94fc
         pJLEs7XvNhXzpztVme6zUiYNR0nX7auBHU+gEW72oIP6YYV8dD+TTOYQO4l64dBmr8Pq
         86p6dwdYkHJl0g3ihuChJz4XU/9AxXOPvBqbQFcJfOSIpyk5P56jo5U5d/kpB0mj6M2a
         uHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=HaKeWaqkrfXv+64QiSgiTLDyjul9QkfLIACSdSBaWtY8oxPhlc0lITTS5zySTdn7Zv
         /rK9tnmwGRfuzXtny74tRtcrVb9w/Ax2AraLhqJWcw1uOdp7pE9KuTSU+EXJuHRIgJBi
         ljp6MTYUYCLBbnBvTj9NJT2Oz0Egv5YOLNQjbO5oDZkurT4vo6Hcn39/MXxrLTRDWy10
         tNFY88GjlJG4gxRzVWPMW66f9jsY/ZsUM7svzyWaq1FwRJVtrnjFAke9lU6Lo0l4fh4L
         6srqnBlKOQzRJffAnIEbAxaVrOrCga0fkU8s8Q8eRmsHLLh+GH2KP3HqC5Nx5IFJl51z
         MCjQ==
X-Gm-Message-State: AFqh2kqJG1/NLkZu9U8+fyC5QHAN5BNfursRKb46foHw+KArZRXmYLP2
        QZZTrRvYwBdY2l996NzX9PpoTIieOUtIi+NdWvw=
X-Google-Smtp-Source: AMrXdXsY401maJ5ebiV7pFWxCy19PuHgqf+GAEd+vlQMLzR+tGdq4MT2AYFgM8J7gv0BVw3ba0R9tLRnaT02rTI2hxY=
X-Received: by 2002:a17:90a:ff11:b0:229:272c:bef8 with SMTP id
 ce17-20020a17090aff1100b00229272cbef8mr1210835pjb.74.1674137633058; Thu, 19
 Jan 2023 06:13:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:c114:b0:b8:bc46:de69 with HTTP; Thu, 19 Jan 2023
 06:13:52 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <sb8766198@gmail.com>
Date:   Thu, 19 Jan 2023 06:13:52 -0800
Message-ID: <CALhHHanAJJHiJbbpVe0oH6EjN3ae7wQj3PrjVbE1q1xUVpyWdA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
