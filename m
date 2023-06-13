Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643B372E1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbjFMLoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMLoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:44:21 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F0BA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:44:20 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-55a35e2a430so3196310eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686656660; x=1689248660;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3GdkHj0zb5hOx3cx3gD8PXJ2xlKGGL8Uae4FjGUDyo=;
        b=kvvO3UcgsEDuDef5yhOt896tbxPvHc6zCtWQBlh237bCvTznt/DK2zqV9W4j2P1pIQ
         JEhrbyobhusguKUZfD8p3X7tKDmMPuGMkg/I1vhSNSTNdz/fsd+IywPFtB8uf3EZ2yFu
         UCFcCmxpOOt2EyS3SpCiZ2flN8QAi3JEUF1RGnYtDeOcwjRiQ98s5VYWaOwd8sxa2s+I
         x+we/W1z0U2PyQiTSvIa1BcEh3zjhoYGA0nvf1VoCeTf/c8jB9UKDzf4Kg+S6y/9kBSi
         FuJfEuiyx+q+tFm9sxRvkdqQZ1M6YLM60XxZciOzcBg8mXIXVp/guvGBLbaElmWgb3+Y
         QIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686656660; x=1689248660;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3GdkHj0zb5hOx3cx3gD8PXJ2xlKGGL8Uae4FjGUDyo=;
        b=MgYHv178QqoyqGzhMJQu/tY4Bn0gICDBWWJLl4YrlV96AXw1oY4af/0sCjH7du/Khp
         esHjf/DvtcDgamYLmutGlZPaURrJ28A4fwTJgdHFJLtmgmeo45w3nl9G9pGH65EaZzAt
         vJy65ruz20fPP1HxHet+dI6nJ1ZAvaLU//e9XeqOKDw9MYPDmStev3Ame+PqK/sRE7Dh
         zUnWKBe9v7Ee8XdetVbkhFRxo3O/jv+yqrVnUotQ/sgxWp5wO9klSCVX8d16eI8ZIdQc
         bNP5gDjwrFfGy+GK3jIekHoUWKsp6vFvbqeGWsFdrUALlNCDrgS1GGCMNI0VtIKmyzs/
         tGlQ==
X-Gm-Message-State: AC+VfDxY8+IJy5shf0QhFAek9zj54V4n9tteFGWZpEmd4Sz9Kw1GRgd2
        2DYU9I8lsjVcfT5aWcsQw33gdVusCQJod77BkBs=
X-Google-Smtp-Source: ACHHUZ6YpaL0sdrCH/ghzUhZ4RMs9bjputSSGZ5Qq8MM7tZoWKZOUSyD7rp4mV8YZsk90+vIMdu+eQI4VTG7w7ay2N0=
X-Received: by 2002:a4a:d1ba:0:b0:556:1d98:b099 with SMTP id
 z26-20020a4ad1ba000000b005561d98b099mr7107033oor.3.1686656659825; Tue, 13 Jun
 2023 04:44:19 -0700 (PDT)
MIME-Version: 1.0
Reply-To: isabellasayouba0@gmail.com
Sender: mrkaboreisa20@gmail.com
Received: by 2002:a05:6358:9209:b0:11e:c85f:ada3 with HTTP; Tue, 13 Jun 2023
 04:44:19 -0700 (PDT)
From:   Mrs Isabella Sayouba <isabellasayouba0@gmail.com>
Date:   Tue, 13 Jun 2023 00:44:19 -1100
X-Google-Sender-Auth: 8SB8WhD1Nl3VMR-MQ5XQ1u0Y_qs
Message-ID: <CADqnB4v43c2rFeYnU8KGWdUx21xHMASBf_iE7N4pa21YmLLpfg@mail.gmail.com>
Subject: =?UTF-8?B?6Kaq5oSb44Gq44KL56We44Gu6YG45oqe44CC?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6Kaq5oSb44Gq44KL56We44Gu6YG45oqe44CCDQoNCuengeOBr+ebruOBq+Wkp+eykuOBrua2meOC
kua1geOBl+OAgeW/g+OBq+a3seOBhOaCsuOBl+OBv+OCkuaEn+OBmOOBquOBjOOCieOBk+OBruOD
oeODvOODq+OCkuabuOOBhOOBpuOBhOOBvuOBmeOAgiDnp4Hjga7lkI3liY3jga/jgqTjgrbjg5nj
g6kNCuOCteODpuODkOOBleOCk+OBp+OBmeOAguODgeODpeODi+OCuOOCouWHuui6q+OBp+OAgeOD
luODq+OCreODiuODleOCoeOCveOBrueXhemZouOBi+OCiemAo+e1oeOBl+OBpuOBhOOBvuOBmeOA
gg0K44GC44Gq44Gf44Gr5b+D44KS6ZaL44GE44Gm44GP44KM44Gf44Gu44Gn44CB44GT44KM44KS
5Lyd44GI44KL5Lul5aSW44Gr6YG45oqe6IKi44GM44Gq44GL44Gj44Gf44Gu44Gn44CB44GT44KM
44KS5Lyd44GI44Gf44GE44Go5oCd44GE44G+44GZ44CCDQrnp4Hjga/jg5bjg6vjgq3jg4rjg5Xj
gqHjgr3jga7jg4Hjg6Xjg4vjgrjjgqLlpKfkvb/jgajjgajjgoLjgasyMDE25bm044Gr5Lqh44GP
44Gq44KL44G+44GnMTXlubTplpPlg43jgYTjgZ/jgrXjg6bjg5Djg7vjg5bjg6njgqbjg7PmsI/j
gajntZDlqZrjgZfjgb7jgZfjgZ/jgILntZDlqZrjgZfjgaYxMeW5tOmWk+WtkOS+m+OBr+OBhOOB
vuOBm+OCk+OBp+OBl+OBn+OAgg0KDQrlvbzjga/jgo/jgZrjgYsz5pel6ZaT44GX44GL57aa44GL
44Gq44GL44Gj44Gf55+t44GE55eF5rCX44Gu5b6M44Gr5Lqh44GP44Gq44KK44G+44GX44Gf44CC
IOW9vOOBruatu+S7peadpeOAgiDnp4Hjga/lho3lqZrjgZfjgarjgYTjgZPjgajjgavmsbrjgoHj
gb7jgZfjgZ/jgIINCuengeOBruS6oeOBjeWkq+OBr+eUn+WJjeOAgee3j+mhjTg1MOS4h+ODieOD
q+OCkumgkOOBkeOBpuOBhOOBvuOBl+OBn+OAgiDopb/jgqLjg5Xjg6rjgqvjga7jg5bjg6vjgq3j
g4rjg5XjgqHjgr3jga7pppbpg73jg6/jgqzjg4njgqXjgrDjg7zjga7pioDooYzjgavjgYLjgovv
vIg4NTDkuIfjg4njg6vvvInjgIINCuePvuWcqOOAgeOBk+OBruOBiumHkeOBr+OBvuOBoOmKgOih
jOOBq+OBguOCiuOBvuOBmeOAgiDlvbzjga/jgZPjga7jgYrph5HjgpLjg5bjg6vjgq3jg4rjg5Xj
gqHjgr3jga7pibHlsbHjgYvjgonjga7ph5Hjga7ovLjlh7rjgYvjgonliKnnlKjjgZfjgb7jgZfj
gZ/jgIINCg0K5pyA6L+R44CB5Yy75bir44GL44KJ44CB6KGA5ray44Gu44GM44KT44Go5Ye66KGA
5oCn6ISz5Y2S5Lit44Gu44Gf44KB44CB44GC44GoN+OBi+aciOOCguaMgeOBn+OBquOBhOOBqOio
gOOCj+OCjOOBvuOBl+OBn+OAgg0K56eB44Gu54q25oWL44KS55+l44Gj44Gf44Gu44Gn44CB56eB
44Gv5oG144G+44KM44Gq44GE5Lq644CF44Gu5LiW6Kmx44KS44GZ44KL44Gf44KB44Gr44GT44Gu
44GK6YeR44KS44GC44Gq44Gf44Gr5rih44GZ44GT44Go44Gr44GX44G+44GX44Gf44CC44GC44Gq
44Gf44Gv44GT44Gu44GK6YeR44KS56eB44GM44GT44GT44Gn5oyH56S644GZ44KL5pa55rOV44Gn
5rS755So44GX44Gm44GP44Gg44GV44GE44CCDQrlkIjoqIjph5HpoY3jga4gMzAg44OR44O844K7
44Oz44OI44KS5YCL5Lq655qE44Gq5L2/55So44Gu44Gf44KB44Gr5Y+X44GR5Y+W44Gj44Gm44GP
44Gg44GV44GE44CCIOOBiumHkeOBriA3MCUg44Gv44CB56eB44Gu5Lqh44GN5aSr44Gu5ZCN5YmN
44Gn5a2k5YWQ6Zmi44KS5bu644Gm44KL44Gu44Gr5L2/44KP44KM44G+44GZ44CCDQrjgZ3jgZfj
gabot6/kuIrjga7osqfjgZfjgYTkurrjgIXjgpLliqnjgZHjgabjgY/jgaDjgZXjgYTjgIIg56eB
44Gv5a2k5YWQ44Go44GX44Gm6IKy44Gh44CB5a625peP44Gu5LiA5ZOh44Go44Gq44KL5Lq644Gv
6Kqw44KC44GK44KJ44Ga44CB44Gf44Gg56We44Gu5a6244KS57at5oyB44GZ44KL44Gf44KB44Gr
5Yqq5Yqb44GZ44KL44Gg44GR44Gn44GZ44CCDQrkuqHjgY3lpKvjga7poZjjgYTjga7jgZ/jgoHj
gIHjgZPjgpPjgarjgZPjgajjgpLjgZfjgabjgYTjgb7jgZnjgIIg44GT44Gu55eF5rCX44Gv56eB
44Gr5aSn44GN44Gq5b2x6Z+/44KS5LiO44GI44G+44GX44Gf44CCIOengeOBr+OBvuOBleOBq+eU
n+OBkeOCi+atu+OBruOCiOOBhuOBquOCguOBruOBp+OBmeOAgg0KDQrov5TkuovjgpLlj5fjgZHl
j5bjgormrKHnrKzjgIIg56eB44Gv44GC44Gq44Gf44Gr44OW44Or44Kt44OK44OV44Kh44K944Gu
6YqA6KGM44Gu6YCj57Wh5YWI44KS5pWZ44GI44G+44GZ44CC44G+44Gf44CB6YqA6KGM5pSv5bqX
6ZW344Gr5oyH56S644GX44Gm44CB44GC44Gq44Gf44GM6YqA6KGM44Gu44GK6YeR44Gu54++5Zyo
44Gu5Y+X55uK6ICF44Gn44GC44KL44GT44Go44KS6Ki85piO44GZ44KL5qip6ZmQ44Gu44GC44KL
5omL57SZ44KS55m66KGM44GZ44KL44KI44GG44Gr5oyH56S644GX44G+44GZ44CC44Gk44G+44KK
44CB44GC44Gq44Gf44GM6KGM5YuV44GZ44KL44GT44Go44KS56eB44Gr5L+d6Ki844GX44Gm44GP
44KM44KL5aC05ZCI44Gn44GZ44CCDQrjgZfjgZ/jgYzjgaPjgabjgIHjgZPjgZPjgafov7Djgbnj
gZ/jgajjgYrjgorjgafjgZnjgIINCg0K5pep5oCl44Gq44GU6L+U562U44KS5b+D44KI44KK44GK
5b6F44Gh55Sz44GX5LiK44GS44Gm44GK44KK44G+44GZ44CCDQoNCuOBguOCiuOBjOOBqOOBhuOA
gg0KDQrjgq3jg6rjgrnjg4jjgavjgYLjgovjgYLjgarjgZ/jga7lp4nlprkNCg0KICDjgqTjgrbj
g5njg6njg7vjgrXjg6bjg7zjg5DjgZXjgpPjgIINCg==
