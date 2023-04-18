Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA586E558B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDRAAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDRAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:00:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63127198E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:00:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fw30so15896825ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681776019; x=1684368019;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtPJH3jqVVBjFVDIks2nPQF+6tDodj36jgdumuqDys8=;
        b=JVN5Vmbw1+1bApGqMRB5ByMgfMo+J6jDiF3RAGeoYlqdCXQLV6kuNvvJq5Izv7Q0jd
         +SnXTxx89kEXqocUZTqgArGA5BkvWlBBtZG/HzQ0CKlz0xTlqpxaPDttaP/Ria+MWSMu
         MSWX06qNDJ9XmHRknD+To6Z/+pz6ppFctRHzQhliuClVjNX2eAed2FK2Z7G3GzoBdDtf
         VjoWfW+bX3ig0JbIueMJgFgFnPdnLgqlYh5g+g/i4g5/ej5D343tfYJ/UKvFpz8lNsCA
         8Xj9Ml3vp/rHLEBVIVmYjDlUj1Z24lhFPj3n9IYQZYANB94jnTRJyOioI42vksqfHDVF
         6zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681776019; x=1684368019;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtPJH3jqVVBjFVDIks2nPQF+6tDodj36jgdumuqDys8=;
        b=Mf48bX/r2PWFfSa5RyrWi/nAH+/pk7ts/LG4c+sYIEEV8+lM7H6aWZtHvnpZB2KjdI
         PTDdud1CPvLQsz05WPMcuDxMotGWtUg8J3ApFEsbO2QzMeZqkzV48Fw806KdRTa/xjxm
         I28+3Eop+tXKi2n5i6kyxSGs15hstrefkyMDfVosliUcb9dEYs5kj44t0i90/lT4QScP
         RB25AVXe9YdufsMKOfKuaewoUsKqSWCFEQX3jOWRvtSo+5STRdRe6t5jH+Q2yqmyiwcM
         gDz59CvTc3ja5vaHjA82kynY9+4IpLOibdDJInFW143jJQPQUX6rfnkqcoTEJlFJskFq
         kiIw==
X-Gm-Message-State: AAQBX9fZ3BcrMEd3mqUDnOF1zbgcX0eDQ8SeKPyq088Az2VWVuOkXKQ9
        zYrjBDaVNW4U8DSlr9pTR0CQmj7l8+o81CavKIU=
X-Google-Smtp-Source: AKy350ZAAOtN6AaF8wRm3m7WSUkAUrXhdaBaNtP2GS2QKFOavbxF9ZoMudZNjU47PZ9VlcE5/6ybxBnaKlQhlZfVd/8=
X-Received: by 2002:a17:906:338e:b0:94d:7dd4:296f with SMTP id
 v14-20020a170906338e00b0094d7dd4296fmr4580892eja.14.1681776018772; Mon, 17
 Apr 2023 17:00:18 -0700 (PDT)
MIME-Version: 1.0
Sender: soliutaibat1@gmail.com
Received: by 2002:a54:3690:0:b0:1f2:cf76:a809 with HTTP; Mon, 17 Apr 2023
 17:00:18 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Mon, 17 Apr 2023 18:00:18 -0600
X-Google-Sender-Auth: vWwXfq7Xvj9zV7175M45jl4ZN2o
Message-ID: <CAMaLA6UKFKAuW8zt1a=2dAPYUmT3xdBz8=3v9vtOhM3TqXD+qg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Mrs. Margaret Christopher
