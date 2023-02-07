Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8B68DA07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjBGOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjBGOBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:01:49 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B46A51
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:01:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u27so15630231ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GkcBItcl+vj8r5JthQWxoWrt4nWlyhRi0oglGfmHW3E=;
        b=ZeEMFBxl+6Inzr5ccvUtZt852U7IiYwQqCHbQh9pmR2bWA9guT9Lc0vNqyp/VGCRFr
         Nhf90yhyGrzrxIVEm4oRT8SlxkQDncJSQyMPfanbvHLLg2A0rdyNcugZoQxp2Oy7UOUs
         MPmYf4nIZ7RJj7d4vsi/JVGJX5UXu8OkWr03CMAO3BzjPsip1SxYlDpbWKftQtOF5Bi2
         nO6iuV1EAjTZVGoAPbzc0M2437L6yP1xw/fOSrusQgcgSkhKwf1ZiciaOeku935J50K7
         XHfnnVKBTwVePcodvweVcGNZmPsC3CWH6yLaKYam/KcwLmturwcWWYmJaAt2wpDB6Re+
         ZijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkcBItcl+vj8r5JthQWxoWrt4nWlyhRi0oglGfmHW3E=;
        b=z9/tg5hHSSwDCqM/Ywqs9DgALSAsb28jHnWGs40UHHpiQ4NeiZXcJ4eRKW+R7awh5d
         uSo90LxNLhwZ3aCT/CTIJDoyHkU8Vnjd+9Ih/7lEg7P6f/FgkOr5LqrLifDe5sPLF0mp
         AwivAZv26WChmHp7FZrDWHFIfTbEFviak5cEcncOY9kWD5wDanY3hxBbYIDUhJ6WscO4
         jZ6s8wYluaPzn7O/gSmHeH7hco5dmVi26/t+bSVkcVGTBtIrFu8ku92fFrqMJ12NEmwF
         5USvMHUUr6iPGQjkjg2UARDDZ4EiIeJxgKg+6+FLCpNuPT8SXH4Hz+cY5qT1rI4aEKzi
         eePw==
X-Gm-Message-State: AO0yUKUv7ic50cfBel+E0GnRVmtIGL0iVSFkUrbXOoOdUPyaIXLgkdpy
        D1Wsbxkpodz/JHy/fOVt7BMoky3deiKeGdReMNI=
X-Google-Smtp-Source: AK7set8YaKdJN4ZvdtTOIiZDxbrMZa+8aHEa4bDSCzPc8yUTXn5ojuTB486gC5GqxDwwg8ebrlvco73l3LbLRSMezd0=
X-Received: by 2002:a2e:aa1c:0:b0:290:7d15:464b with SMTP id
 bf28-20020a2eaa1c000000b002907d15464bmr478275ljb.146.1675778461892; Tue, 07
 Feb 2023 06:01:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:9cc5:0:0:0:0:0 with HTTP; Tue, 7 Feb 2023 06:01:01 -0800 (PST)
From:   Francis Kwame <franciskwame575@gmail.com>
Date:   Tue, 7 Feb 2023 14:01:01 +0000
Message-ID: <CANiRMRMGwwxaCvXda5YZz_Pz1D+fB79qZAyiq31AdbSsOkpU8A@mail.gmail.com>
Subject: Re: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On my honor as your late relative's personal atorney, I hereby
officially invite you to his inher!tance proposal.
Permit me to give you more information.

Sincerely,

-- 
Francis Kwame. Esq
Principal Attorney of
Dominion Associates
Chambers Barristers & Solicitors
Public Notary , BTD/SORT-CD-00247901
