Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A712746FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGDLee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGDLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:34:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81E113;
        Tue,  4 Jul 2023 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688470468; x=1689075268; i=rwarsow@gmx.de;
 bh=YZybEmJyuuzv98qi2L8NshFm9B1/NZqXgmwmjpLfzyA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=Y56f2Iz23Lu+Hc7gluXo8j3wMk2+dhy62zAvooJLs5AOy0H2xef9Ty228OkmCDtxr0x1kZf
 TBnEV0duzwJA+tVt23GhIez7SG3QomlhLMGicvnyuwUQgrlJ/XteR5remoNQPK66fKvQiZ5N8
 QIUQvEq/hTbDsPLwA9uIb6hsuU+7lMbTvX7H0YqFqaLwakb7MRIlZknTkjzeHErypK5qtTRwC
 Pwx659FKQJLpK/PQ9tyYXGRQ/7MW7dQcYoLSTPGER/6Dp0V6SuUohL6ToQyqktek/ZkUDYolX
 X4pZWEWKY/a8pGF5IOqSDxgd3basKWy6qOhuS5oxKlNmCq1hSjAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.4]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1poDJE05hQ-00g2CG; Tue, 04
 Jul 2023 13:34:28 +0200
Message-ID: <80791249-bdc3-2afb-bccc-99b9285966b2@gmx.de>
Date:   Tue, 4 Jul 2023 13:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 00/15] 6.4.2-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6WUIJG1LcOSboUxZZKQewdgRlUaSNVCzG5mimZqi3jwyPaqhCxu
 WFW4z9Ihf4WSNqnb/xpbqqJv4rPfDk61xdyYfJ/r5bzXSQzWD/rDM+0ig5aFcDRyVcdjRI4
 pLtUi535HhjgPDRrKFXaOgzblFhQbhxAi5F426/0DUfDlRqXsO5+eHpRWYrfgUhZFx2wsve
 WV/ENZRY8peD5MmCX4eMw==
UI-OutboundReport: notjunk:1;M01:P0:yDpehXSkUQ0=;s+DyXwUFVDz/tLIO9WwQilqlxmF
 h+gvi2Ma4n+RFF/+8wvyF4RKDxOr6NsVdwV8j3Mw/AgA17DYvcNeLPKhA6SYvxzY/973sJ3AB
 k03Tf40sd9a0JzEOcDma5SYHk2l0++p2bDOl6g9sA84Czi+IK1KJG0ueb1JXfjj6wmOcRA3rt
 y1n6LU/kt45K5LgRuQnOzu2lmoKoCR32aG6/a2CF07u+QQhKMY79052XE98ldk8iGqpetxCfg
 I70Tk2wgT1nMGBl8c14CtFGzCQsJ6zvk9ECEeoKXkZS73PjliMH9a6B3MmlSjSSimgQqLpIJR
 0fT++B0C+AaHccMw26tgJT6qMRNFdCMCDNV58j5Yqw/5Tlxiity+goXherhXIqh1HHmC3z/Nn
 xMzBcXkIGWw30g4tJ3I93CueDvcR5dl7ae9mlENb7CaUOxzl8GiyZW5W5oPFfHhrdtFfodGAB
 mIbXX99fKpIqhmQkLyFdVZtu7Jt0elsiT5Gs+rQZWoL/HwVRnWlHPd/efXwMagm/Ov8yyVf8V
 F9TrRlQl38jojmTVZRt2/LfuEijxIPpqcu1Zvnb/3yLyq9SinnFXm6k6DWjBCG5dPz+rgE9QT
 zCyrqMVpKRmbFpTwTVYi9dFRJUHcIibJ6pb91HNn/tOeTG0MImTsjmUhnYHB9pFo15SEha127
 XjJ+a35CR0hk6tLDjQV4XrGPo8IUWTxiy0Gt4rijEsl4hXAhVbXduFb2rp1o7SVmrchAl7Nt6
 U5nBqGHeb5IhovsSqYF9VZTOb/Sj/hwDPm4QcYOcRP+JmSOBNNX+Ua0rYGejTprpN2yXxbEoF
 Wx2roi/Tt1FjvjxSpFW/OLPj3WqGBL3VXc+zmzMQZKn7s/Uq6vGJsO1M/GfL1/M7np6ZkU5ms
 sbBVm25fPwH+Ok6zinpOjEAziXY3UEV7r0hfmEldKZXll8xpFqBCLCnA1XMUbp2yoEAr0+kPJ
 8Mzaaw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.2-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

