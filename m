Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC926E8668
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjDTA0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjDTA0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:26:48 -0400
X-Greylist: delayed 618 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 17:26:33 PDT
Received: from mail.heimpalkorhaz.hu (mail.heimpalkorhaz.hu [193.224.51.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007F65AA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:26:33 -0700 (PDT)
Received: from mail.heimpalkorhaz.hu (localhost [127.0.0.1])
        (Authenticated sender: lmateisz@heimpalkorhaz.hu)
        by mail.heimpalkorhaz.hu (Postfix) with ESMTPA id 2E4F1384A1BD4E;
        Thu, 20 Apr 2023 01:36:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.heimpalkorhaz.hu 2E4F1384A1BD4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heimpalkorhaz.hu;
        s=default; t=1681947380;
        bh=SFPaiUyYqM5Iz1wf9UVYSHssSttYIu6SPYgIrz5naIQ=;
        h=Date:From:To:Subject:Reply-To:From;
        b=JtBkHnyNQ5x5tnP4PUQgw4GJ+Qz8Z3zs1U+Pm24n4z91HWvgoFQ7kBk9p3dIncWuc
         77zCHaxjK71sJwQ5LX1jYL/aXVV4eKz8mEAWn9BcRze6KBSL+waYaTMV9nbxeQcdwV
         kljPbkt2Ye02VooqqlANUiZ4cJ+QNktWBPxWYpvtk7PAQjL+fGt2HydB+Jgw0Fy0/o
         Fq5XphI+tcydc9wrbr0mME4H+H908q5UL/FCBwYWLmcvmXX+4zV+uQtZKSZpTxVl5k
         w1wGPxRAGOSPCgtMAznGLrQi456Le7yz4ui1jCliaF/XjW7Niwf8zvdaA1P5BhEru3
         StR2CDd1oU64w==
MIME-Version: 1.0
Date:   Thu, 20 Apr 2023 07:36:19 +0800
From:   mk <mk@heimpalkorhaz.hu>
To:     undisclosed-recipients:;
Subject: Hej solsken
Reply-To: marionn.k99@gmail.com
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2de98351b83183a992aed2435d03d452@heimpalkorhaz.hu>
X-Sender: mk@heimpalkorhaz.hu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [5.41 / 20.00];
        R_UNDISC_RCPT(3.00)[];
        FORGED_RECIPIENTS(2.00)[m:,s:lifeinsurance.net@novbackup18.icu,s:lifeinsurance.net@novhelp18.icu,s:lifeinsurance.net@novnet18.icu,s:lifeinsurance.net@novuser18.icu,s:lifeinsurance.net@nowcanoeing02today.stream,s:lifeinsurance.net@nuarne.live,s:lifeinsurance.net@oatrant.info,s:lifeinsurance.net@phres.icu,s:lifeinsurance.net@praka.icu,s:lifeinsurance.net@reedost.icu,s:lifeinsurance.net@risaroge.icu,s:lifeinsurance.net@shaif.icu,s:lifeinsurance.net@shumax.icu,s:lifeinsurance.net@shums.info,s:lifeinsurance.net@tabin.icu,s:lifeinsurance.net@thainor.info,s:lifeinsurance.net@tholi.icu,s:lifestyle@synsam.com,s:lifesum@communication.lifesum.com,s:light4ck@earthlink.net,s:lightning@hol.gr,s:liisabobacka@gmail.com,s:liisa.sulin-elmqvist@arbetslivsresurs.se,s:liisiw@hotmail.com,s:liiv-carolyn@goodinformed.com,s:lijesnic@telia.com,s:likos-celeste@dungy.info,s:lilian.axelsson@gavlefastigheter.se,s:lilian.b@live.se,s:lilian.cassin@iaa.ie,s:lilian.larsson@bahnhof.se,s:lilian.melin@bahnhof.se,s:lili
 an.sjolund@mittmedia.se,s:liliansjostrom43@gmail.com,s:lilian.stalhammar@telia.com,s:lilian13153@telia.com,s:lilianne.axelsson@bylero.se,s:lilianne.axelsson@matla.se,s:lilin@arkitema.com,s:liliya2408@mail.ru,s:lilja1945@live.se,s:lilja@bahnhof.se,s:liljegrenkurt@gmail.com,s:liljestrand@bahnhof.se,s:lilka.l@centrum.cz,s:lilkama08@yahoo.com,s:lillalivet@post.utfors.se,s:lillamy31@gmail.com,s:lillan.sjolund@mittmedia.se,s:lillaryd@bahnhof.se,s:lillatjarbygard@hotmail.com,s:lillelola1@hotmail.com,s:lillemoja@yahoo.se,s:lillemor.nordenmark@if.se,s:lillemorschultz@gmail.com,s:lillemorskolving@gmail.com,s:lillemor@qimage.se,s:lillemorlomyr@gmail.com,s:lillemormax@hotmail.com,s:lillemorunger@hotmail.com,s:lillianappelqvist@gmail.com,s:lillian.sjolund@mittmedia.se,s:lillian_mead@courtgeneraljudge.icu,s:lillian_michealson@bestscanjune.stream,s:lillie.artis@purmov.info,s:lillisadelind@hotmail.com,s:lillmarieapersson@gmail.com,s:lillsomiss@gmail.com,s:lillvi.arhage@icloud.com,s:lilly.95@hotmail
 .com,s:lilly.backlund@lycksele.se,s:lilly.nilsson@hotmail.com,s:lilly.nordin11@bredband.net,s:lilly.wen@ericsson.com,s:lily@onertronics.com,s:limbertilanfranco@gmail.com,s:limmel.rosalyn@baudy.icu,s:lin005gad@icloud.com,s:linaaalmgren@gmail.com,s:lina.barremyr@hotmail.com,s:lina.barremyr@hotmail.cvom,s:linabostrom82@gmail.com,s:lina.boy@sd.se,s:lina.dahlberg@telia.com,s:lina.golden@thegridgroup.se,s:lina.ivert@sll.se,s:lina.iyer@linaro.org,s:lina.jarledal.blom@regionostergotland.se,s:lina.johannesson@vardforbundet.se,s:lina.karlsson89@live.se,s:linamholmberg@gmail.com,s:linanolin@gmail.com,s:lina.persson@lila.se,s:linaydrefelt@gmail.com,s:lina@5kh9cw7.cyq32.8chameleon.eu,s:lina@dhzt2k.h6ynz.dsnake.eu,s:lina@elxthpnbr.at8g1.hprimate.eu,s:lina@g-tech.se,s:lina@www16.nchameleon.eu];
        R_MIXED_CHARSET(1.10)[];
        GENERIC_REPUTATION(-0.59)[-0.58894983573457];
        MIME_GOOD(-0.10)[text/plain];
        RCVD_COUNT_ZERO(0.00)[0];
        MIME_TRACE(0.00)[0:+];
        FROM_EQ_ENVFROM(0.00)[];
        TO_DN_ALL(0.00)[];
        RCPT_COUNT_ONE(0.00)[1];
        REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
        FROM_HAS_DN(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        FREEMAIL_ENVRCPT(0.00)[earthlink.net,gmail.com,hotmail.com,live.se,mail.ru,centrum.cz,yahoo.com,yahoo.se,icloud.com,msn.com,me.com,europe.com,outlook.com,rocketmail.com,home.se,wanadoo.fr,comcast.net,spray.se,163.com,yahoo.it,hotmail.it,hotmail.es,aol.com,onet.eu,live.com,web.de,yahoo.de,bigpond.com];
        FREEMAIL_REPLYTO(0.00)[gmail.com];
        TAGGED_RCPT(0.00)[];
        HAS_REPLYTO(0.00)[marionn.k99@gmail.com]
X-Rspamd-Queue-Id: 2E4F1384A1BD4E
X-Rspamd-Server: mail.heimpalkorhaz.hu
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej min kära,

Jag är ledsen att jag stör dig och inkräktar på din integritet. Jag är 
singel, ensam och i behov av en omtänksam, kärleksfull och romantisk 
följeslagare.

Jag är en hemlig beundrare och skulle vilja utforska möjligheten att 
lära mig mer om varandra. Jag vet att det är konstigt att kontakta dig 
på det här sättet och jag hoppas att du kan förlåta mig. Jag är en blyg 
person och det är det enda sättet jag vet att jag kan få din 
uppmärksamhet. Jag vill bara veta vad du tycker och min avsikt är inte 
att förolämpa dig. Jag hoppas att vi kan vara vänner om det är vad du 
vill, även om jag vill vara mer än bara en vän. Jag vet att du har några 
frågor att ställa och jag hoppas att jag kan tillfredsställa en del av 
din nyfikenhet med några svar.

Jag tror på talesättet att för världen är du bara en person, men för 
någon speciell är du världen, allt jag vill ha är kärlek, romantisk 
omsorg och uppmärksamhet från en speciell följeslagare som jag hoppas 
skulle vara du.

Jag hoppas att detta meddelande kommer att bli början på en långsiktig 
kommunikation mellan oss, skicka bara ett svar på detta meddelande, det 
kommer att göra mig glad.

Puss och kram,

Marion.
