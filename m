Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB370DCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjEWMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbjEWMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:48:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA051AD;
        Tue, 23 May 2023 05:48:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53033a0b473so5165410a12.0;
        Tue, 23 May 2023 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684846118; x=1687438118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+luJcpnDqm+8+ya6draBWUeu0r+QunqXQzG/ngCVWE=;
        b=L01Yxi54Oo6q+9Bjt3sEn3NMpYld/wO3CBq2BdI95nhVavzMbfrHIOmKTmh7TP5PLy
         rX4bVJB7xaLYk29lSa/XK+Hv/50UcCHKto6d3cjCRyOcY9DbtAF/3gOmiRzwMgWgS99o
         Yyqpl1jiFYyeEf5FKK6qmg85v0uUui/14PuAVZBDqupxtWYN/PinMMyqkEAcWoaxqeRg
         UcNmFEZRuOtrw/7aQ5P2AGzhGwp7HmB/S8m1x/Bsvsh5i3gIPJxDSGyZkjKmYFgy4Ep6
         NL0BXI+4s8rDbyCTPsSUdYPe/7W5hxP6e5XtqYK8G6rzuUJww0kzLF1u5+OBHKcWb9xU
         FW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684846118; x=1687438118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+luJcpnDqm+8+ya6draBWUeu0r+QunqXQzG/ngCVWE=;
        b=OwE3P2p01ms6gr4XF9MqNNqyj+W8Yn5u/W4UkQKzSMXU3nIKAxiA5YLC5kvor+QJoZ
         NLg9ZZ5slzhPGafhVl6JGE9Wjbt46FjOZPLqQ3O31jlnqFoO8lafzQxRqtj6JQOh1WpD
         9NxFW5MiQOrSR24mI6Ia3scTGnGWci0VKmZfMyjBr8TKYMNHJuVigjR0tzY8Li0HRwSs
         cdTUVt0ZyY9i9PipEhdzHEO86ezIsAjQvJbbfJmLcIy7yoeRzZkjh84126NaYjYN3epv
         +5f3da+WUTe6LDUvTl6rGhCjMgqDd6uBMZ53VVu5I/Y20xCA/Pn9ddHX0pdCQVUl3qqW
         Gj0g==
X-Gm-Message-State: AC+VfDwl+Dozl0fn+9LQqMkH5WOp9cuc/Qv1B4p+GdF8ZAOc9I0sfnrS
        71LdBUn9I/L6efo4xBEcE2Y=
X-Google-Smtp-Source: ACHHUZ5dFsCRzWBgAhyoG3sD+YVv98rtQyBuK1AwpbLs/ugAraGkuzXE8ahejEHSa8TTw0rWmvd49A==
X-Received: by 2002:a17:90a:5d06:b0:255:6133:f561 with SMTP id s6-20020a17090a5d0600b002556133f561mr6328538pji.10.1684846118045;
        Tue, 23 May 2023 05:48:38 -0700 (PDT)
Received: from yoga ([2400:1f00:13:49e0:15f7:15f4:3a2b:204c])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a1b2200b002508f0ac3edsm8077936pjq.53.2023.05.23.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 05:48:37 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 23 May 2023 18:18:30 +0530
To:     Mark Brown <broonie@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, oder_chiou@realtek.com
Subject: Re: [PATCH] ASoC: dt-bindings: rt1016: Convert to dtschema
Message-ID: <ZGy2Hpo4MvmMw4v+@yoga>
References: <ZFUFAmBJXvkQAG7m@yoga>
 <ZFUFrWqOHVmzE+ut@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUFrWqOHVmzE+ut@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 10:33:33PM +0900, Mark Brown wrote:
> On Fri, May 05, 2023 at 07:00:42PM +0530, Anup Sharma wrote:
> 
> > +maintainers:
> > +  - oder_chiou@realtek.com
> 
> If you're nominating someone as the maintainer for a binding it's
> probably best to copy them on the patch so they're aware...

Hi Mark,

Do I need to send the v2 by copying oder_chiou@realtek.com into the
patch?

I saw you already added him. 

Regards, 
Anup Sharma
