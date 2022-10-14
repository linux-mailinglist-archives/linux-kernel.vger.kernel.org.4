Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822FA5FEB78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJNJVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJNJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:21:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC71BE1F2;
        Fri, 14 Oct 2022 02:21:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 128so3835312pga.1;
        Fri, 14 Oct 2022 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9wMvB3JMaTFSLTm+v+E4+iaAV0RiG8RKMvl7aWzaUs=;
        b=gYllb9A4pvLFozek1fv0suAqxnqyrNM5uZ/XuaO5ITWD2SkU2PpAK/tS6Xu874zIod
         0874RjZZ6SIzp1PBLoghNF9q/i7oYMfQ9a06sGd2PSRg4+i0cPAeW1n8vBO6CzaLfimo
         jrcOFc4eMFpphVjLGnzMabqf1aW8RjQmWa3Yhj51Q8VWq6d0mRzet8xWwrfaJGFh2q06
         ZnQbrhfnVk76bOUdiTWqKb6tCP74cf9Sg3H1wJ2V6K9ON18zutvxsTfoZOyO6lPJVSGI
         OMg40v+sh1Tlkcpn5cdoFr6eLqAJ2h8hF9vRkFD0UNIBZXVC7y17BC5D0Cey8QnP0IXV
         jg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9wMvB3JMaTFSLTm+v+E4+iaAV0RiG8RKMvl7aWzaUs=;
        b=ZhKwRbX5asEsJyTkolsV193jaozD9lzZa6T7X6OODmkPO0NtAe/1p0QNKkWSeQPNEy
         dUPZdclf4slfE/LshS6U+kv6qY3DOmiYPxvWnAfcG5xnqbG3B9zBtZLbGaqMXZtu5zTq
         fDPgUvAK7ivrbg20LRUJfnAnnn29wDk8PDVRUK1ZbKGX0u7Z2BQQn0oKjlUVbgYjuq2s
         99CkPgMMaITpJg/zeqJu8a+3j0CeE/efykMk94fwootZIxwKW8Oq8hum6aKfm0ZX3Psd
         Rb6QgDX0DJI2dS7EtN4VTZ2L3kGfJr8P7DQrH5MfF+1o0CwRZLvGiXy5en/tMUBupOqh
         i9ug==
X-Gm-Message-State: ACrzQf0zL9QV72KRlLELaLLHT5PMjmJ0o4hwTspOtMokoCJgA1/QR4Tr
        /+xIgtU/nS0XPBqdvvLAC4sYUPQFhuO0zQ==
X-Google-Smtp-Source: AMsMyM56sdumX/GoYgeJ+wAIM57D+KPbPzggeMLJHbI4ykj0cSA2imrds4VIowU0xQEgCqJzFBHNYw==
X-Received: by 2002:a62:648e:0:b0:563:3bf5:bf39 with SMTP id y136-20020a62648e000000b005633bf5bf39mr4132493pfb.75.1665739296914;
        Fri, 14 Oct 2022 02:21:36 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016d9d6d05f7sm1244116plg.273.2022.10.14.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 02:21:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D06BF10381F; Fri, 14 Oct 2022 16:21:32 +0700 (WIB)
Date:   Fri, 14 Oct 2022 16:21:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu, ojeda@kernel.org
Subject: Re: [PATCH 2/2] Documentation: Add HOWTO Spanish translation into
 rst based build system
Message-ID: <Y0kqHBwaYvZwTp9M@debian.me>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221013184816.354278-3-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c+AzO54Ki4mg0Ky/"
Content-Disposition: inline
In-Reply-To: <20221013184816.354278-3-carlos.bilbao@amd.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c+AzO54Ki4mg0Ky/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=C2=A1Hola Carlos! Gracias for start writing Spanish translations. However,
the patch can be improved, see below.

On Thu, Oct 13, 2022 at 01:48:16PM -0500, Carlos Bilbao wrote:
> This commit adds Spanish translation of HOWTO document into rst based
> documentation build system.
>=20

Better say "Translate HOWTO document into Spanish".

> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/translations/sp_SP/howto.rst | 619 +++++++++++++++++++++
>  Documentation/translations/sp_SP/index.rst |   7 +
>  2 files changed, 626 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/howto.rst
>=20
> diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/t=
ranslations/sp_SP/howto.rst
> new file mode 100644
> index 000000000000..4cf8fa6b9f7c
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/howto.rst
> @@ -0,0 +1,619 @@
> +.. include:: ./disclaimer-sp.rst
> +
> +:Original: :ref:`Documentation/process/howto.rst <process_howto>`
> +:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
> +
> +.. _sp_process_howto:
> +
> +C=C3=B3mo participar en el desarrollo del kernel de Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Este documento es el principal punto de partida. Contiene instrucciones
> +sobre c=C3=B3mo convertirse en desarrollador del kernel de Linux y expli=
ca c=C3=B3mo
> +trabajar con el y en su desarrollo. El documento no tratar=C3=A1 ning=C3=
=BAn aspecto
> +t=C3=A9cnico relacionado con la programaci=C3=B3n del kernel, pero le ay=
udar=C3=A1
> +gui=C3=A1ndole por el camino correcto.
> +
> +Si algo en este documento quedara obsoleto, env=C3=ADe parches al mainta=
iner de
> +este archivo, que se encuentra en la parte superior del documento.
> +
> +Introducci=C3=B3n
> +------------
> +=C2=BFDe modo que quiere descubrir como convertirse en un/a desarrollado=
r/a del
> +kernel de Linux? Tal vez su jefe le haya dicho, "Escriba un driver de
> +Linux para este dispositivo." El objetivo de este documento en ense=C3=
=B1arle
> +todo cuanto necesita para conseguir esto, describiendo el proceso por el
> +que debe pasar, y con indicaciones de como trabajar con la comunidad.
> +Tambi=C3=A9n trata de explicar las razones por las cuales la comunidad t=
rabaja
> +de la forma en que lo hace.
> +
> +El kernel esta principalmente escrito en C, con algunas partes que son
> +dependientes de la arquitectura en ensamblador. Un buen conocimiento de C
> +es necesario para desarrollar en el kernel. Lenguaje ensamblador (en
> +cualquier arquitectura) no es necesario excepto que planee realizar
> +desarrollo de bajo nivel para dicha arquitectura. Aunque no es un perfec=
to
> +sustituto para una educaci=C3=B3n s=C3=B3lida en C y/o a=C3=B1os de expe=
riencia, los
> +siguientes libros sirven, como m=C3=ADnimo, como referencia:
> +
> +- "The C Programming Language" de Kernighan e Ritchie [Prentice Hall]
> +- "Practical C Programming" de Steve Oualline [O'Reilly]
> +- "C:  A Reference Manual" de Harbison and Steele [Prentice Hall]
> +
> +El kernel est=C3=A1 escrito usando GNU C y la cadena de herramientas GNU=
=2E Si
> +bien se adhiere al est=C3=A1ndar ISO C89, utiliza una serie de extension=
es que
> +no aparecen en dicho est=C3=A1ndar. El kernel usa un C independiente de =
entorno,
> +sin depender de la biblioteca C est=C3=A1ndar, por lo que algunas partes=
 del
> +est=C3=A1ndar C no son compatibles. Divisiones de long long arbitrarios o
> +de coma flotante no son permitidas. En ocasiones, puede ser dif=C3=ADcil=
 de
> +entender las suposiciones que el kernel hace respecto a la cadena de
> +herramientas y las extensiones que usa, y desafortunadamente no hay
> +referencia definitiva para estos. Consulte las p=C3=A1ginas de informaci=
=C3=B3n de
> +gcc (`info gcc`) para obtener informaci=C3=B3n al respecto.
> +
> +Recuerde que est=C3=A1 tratando de aprender a trabajar con una comunidad=
 de
> +desarrollo existente. Es un grupo diverso de personas, con altos est=C3=
=A1ndares
> +de codificaci=C3=B3n, estilo y procedimiento. Estas normas han sido crea=
das a lo
> +largo del tiempo en funci=C3=B3n de lo que se ha encontrado que funciona=
 mejor
> +para un equipo tan grande y geogr=C3=A1ficamente disperso. Trate de apre=
nder
> +tanto como le sea posible acerca de estos est=C3=A1ndares antes de tiemp=
o, ya
> +que est=C3=A1n bien documentados; no espere que la gente se adapte a ust=
ed o a
> +su forma de ser de hacer las cosas.
> +
> +Cuestiones legales
> +------------------
> +El c=C3=B3digo fuente del kernel de Linux se publica bajo licencia GPL. =
Por
> +favor, revise el archivo COPYING, presente en la carpeta principal del
> +fuente, para detalles de la licencia. Si tiene alguna otra pregunta
> +sobre licencias, contacte a un abogado, no pregunte en listas de discusi=
=C3=B3n
> +del kernel de Linux. Las personas en estas listas no son abogadas, y no
> +debe confiar en sus opiniones en materia legal.
> +
> +Para preguntas y respuestas m=C3=A1s frecuentes sobre la licencia GPL, c=
onsulte:
> +
> +	https://www.gnu.org/licenses/gpl-faq.html
> +
> +Documentacion
> +--------------
> +El c=C3=B3digo fuente del kernel de Linux tiene una gran variedad de doc=
umentos
> +que son incre=C3=ADblemente valiosos para aprender a interactuar con la
> +comunidad del kernel. Cuando se agregan nuevas funciones al kernel, se
> +recomienda que se incluyan nuevos archivos de documentaci=C3=B3n que exp=
liquen
> +c=C3=B3mo usar la funci=C3=B3n. Cuando un cambio en el kernel hace que l=
a interfaz
> +que el kernel expone espacio de usuario cambie, se recomienda que env=C3=
=ADe la
> +informaci=C3=B3n o un parche en las p=C3=A1ginas del manual que explique=
n el cambio
> +a mtk.manpages@gmail.com, y CC la lista linux-api@vger.kernel.org.
> +
> +Esta es la lista de archivos que est=C3=A1n en el c=C3=B3digo fuente del=
 kernel y son
> +de obligada lectura:
> +
> +  :ref:`Documentation/admin-guide/README.rst <readme>`
> +    Este archivo ofrece una breve descripci=C3=B3n del kernel de Linux y
> +    describe lo que es necesario hacer para configurar y compilar el
> +    kernel. Quienes sean nuevos en el kernel deben comenzar aqu=C3=AD.
> +
> +  :ref:`Documentation/process/changes.rst <changes>`
> +    Este archivo proporciona una lista de los niveles m=C3=ADnimos de va=
rios
> +    paquetes que son necesarios para construir y ejecutar el kernel
> +    exitosamente.
> +
> +  :ref:`Documentation/process/coding-style.rst <codingstyle>`
> +    Esto describe el estilo de c=C3=B3digo del kernel de Linux y algunas=
 de los
> +    razones detr=C3=A1s de esto. Se espera que todo el c=C3=B3digo nuevo=
 siga las
> +    directrices de este documento. La mayor=C3=ADa de los maintainers so=
lo
> +    aceptar=C3=A1n parches si se siguen estas reglas, y muchas personas =
solo
> +    revisan el c=C3=B3digo si tiene el estilo adecuado.
> +
> +  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> +    Este archivo describe en gran detalle c=C3=B3mo crear con =C3=A9xito=
 y enviar un
> +    parche, que incluye (pero no se limita a):
> +
> +       - Contenidos del correo electr=C3=B3nico (email)
> +       - Formato del email
> +       - A quien se debe enviar
> +
> +    Seguir estas reglas no garantiza el =C3=A9xito (ya que todos los par=
ches son
> +    sujetos a escrutinio de contenido y estilo), pero en caso de no segu=
ir
> +    dichas reglas, el fracaso es pr=C3=A1cticamente garantizado.
> +    Otras excelentes descripciones de c=C3=B3mo crear parches correctame=
nte son:
> +
> +	"The Perfect Patch"
> +		https://www.ozlabs.org/~akpm/stuff/tpp.txt
> +
> +	"Linux kernel patch submission format"
> +		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-f=
ormat.html
> +
> +  :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsen=
se>`
> +    Este archivo describe la l=C3=B3gica detr=C3=A1s de la decisi=C3=B3n=
 consciente de
> +    no tener una API estable dentro del kernel, incluidas cosas como:
> +
> +      - Capas intermedias del subsistema (por compatibilidad?)
> +      - Portabilidad de drivers entre sistemas operativos
> +      - Mitigar el cambio r=C3=A1pido dentro del =C3=A1rbol de fuentes d=
el kernel (o
> +        prevenir cambios r=C3=A1pidos)
> +
> +     Este documento es crucial para comprender la filosof=C3=ADa del des=
arrollo
> +     de Linux y es muy importante para las personas que se mudan a Linux
> +     tras desarrollar otros sistemas operativos.
> +
> +  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +    Si cree que ha encontrado un problema de seguridad en el kernel de
> +    Linux, siga los pasos de este documento para ayudar a notificar a los
> +    desarrolladores del kernel y ayudar a resolver el problema.
> +
> +  :ref:`Documentation/process/management-style.rst <managementstyle>`
> +    Este documento describe c=C3=B3mo operan los maintainers del kernel =
de Linux
> +    y los valores compartidos detr=C3=A1s de sus metodolog=C3=ADas. Esta=
 es una
> +    lectura importante para cualquier persona nueva en el desarrollo del
> +    kernel (o cualquier persona que simplemente sienta curiosidad por
> +    el campo IT), ya que clarifica muchos conceptos err=C3=B3neos y conf=
usiones
> +    comunes sobre el comportamiento =C3=BAnico de los maintainers del ke=
rnel.
> +
> +  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rul=
es>`
> +    Este archivo describe las reglas sobre c=C3=B3mo se suceden las vers=
iones
> +    del kernel estable, y qu=C3=A9 hacer si desea obtener un cambio en u=
na de
> +    estas publicaciones.
> +
> +  :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
> +    Una lista de documentaci=C3=B3n externa relativa al desarrollo del k=
ernel.
> +    Por favor consulte esta lista si no encuentra lo que est=C3=A1n busc=
ando
> +    dentro de la documentaci=C3=B3n del kernel.
> +
> +  :ref:`Documentation/process/applying-patches.rst <applying_patches>`
> +    Una buena introducci=C3=B3n que describe exactamente qu=C3=A9 es un =
parche y c=C3=B3mo
> +    aplicarlo a las diferentes ramas de desarrollo del kernel.
> +
> +El kernel tambi=C3=A9n tiene una gran cantidad de documentos que pueden =
ser
> +generados autom=C3=A1ticamente desde el propio c=C3=B3digo fuente o desde
> +ReStructuredText markups (ReST), como este. Esto incluye un descripci=C3=
=B3n
> +completa de la API en el kernel y reglas sobre c=C3=B3mo manejar cerrojos
> +(locking) correctamente.
> +
> +Todos estos documentos se pueden generar como PDF o HTML ejecutando::
> +
> +	make pdfdocs
> +	make htmldocs
> +
> +respectivamente desde el directorio fuente principal del kernel.
> +
> +Los documentos que utilizan el markup ReST se generar=C3=A1n en
> +Documentation/output. Tambi=C3=A9n se pueden generar en formatos LaTeX y=
 ePub
> +con::
> +
> +	make latexdocs
> +	make epubdocs
> +
> +Convertirse en un/a desarrollador/a de kernel
> +-------------------------------------------
> +
> +Si no sabe nada sobre el desarrollo del kernel de Linux, deber=C3=ADa co=
nsultar
> +el proyecto Linux KernelNewbies:
> +
> +	https://kernelnewbies.org
> +
> +Consiste en una =C3=BAtil lista de correo donde puede preguntar casi cua=
lquier
> +tipo de pregunta b=C3=A1sica de desarrollo del kernel (aseg=C3=BArese de=
 buscar en
> +los archivos primero, antes de preguntar algo que ya ha sido respondido =
en
> +el pasado.) Tambi=C3=A9n tiene un canal IRC que puede usar para hacer pr=
eguntas
> +en en tiempo real, y una gran cantidad de documentaci=C3=B3n =C3=BAtil q=
ue es =C3=BAtil
> +para ir aprendiendo sobre el desarrollo del kernel de Linux.
> +
> +El sitio web tiene informaci=C3=B3n b=C3=A1sica sobre la organizaci=C3=
=B3n del c=C3=B3digo,
> +subsistemas, y proyectos actuales (tanto dentro como fuera del =C3=A1rbo=
l).
> +Tambi=C3=A9n describe alguna informaci=C3=B3n log=C3=ADstica b=C3=A1sica=
, como c=C3=B3mo compilar
> +un kernel y aplicar un parche.
> +
> +Si no sabe por d=C3=B3nde quiere empezar, pero quieres buscar alguna tar=
ea que
> +comenzar a hacer para unirse a la comunidad de desarrollo del kernel,
> +acuda al proyecto Linux Kernel Janitor:
> +
> +	https://kernelnewbies.org/KernelJanitors
> +
> +Es un gran lugar para comenzar. Describe una lista de problemas
> +relativamente simples que deben limpiarse y corregirse dentro del codigo
> +fuente del kernel de Linux =C3=A1rbol de fuentes. Trabajando con los
> +desarrolladores a cargo de este proyecto, aprender=C3=A1 los conceptos b=
=C3=A1sicos
> +para incluir su parche en el =C3=A1rbol del kernel de Linux, y posibleme=
nte
> +descubrir en la direcci=C3=B3n en que trabajar a continuaci=C3=B3n, si n=
o tiene ya
> +una idea.
> +
> +Antes de realizar cualquier modificaci=C3=B3n real al c=C3=B3digo del ke=
rnel de
> +Linux, es imperativo entender c=C3=B3mo funciona el c=C3=B3digo en cuest=
i=C3=B3n. Para
> +este prop=C3=B3sito, nada es mejor que leerlo directamente (lo m=C3=A1s =
complicado
> +est=C3=A1 bien comentado), tal vez incluso con la ayuda de herramientas
> +especializadas. Una de esas herramientas que se recomienda especialmente
> +es el proyecto Linux Cross-Reference, que es capaz de presentar el c=C3=
=B3digo
> +fuente en un formato de p=C3=A1gina web indexada y autorreferencial. Una
> +excelente puesta al d=C3=ADa del repositorio del c=C3=B3digo del kernel =
se puede
> +encontrar en:
> +
> +	https://elixir.bootlin.com/
> +
> +El proceso de desarrollo
> +------------------------
> +
> +El proceso de desarrollo del kernel de Linux consiste actualmente de
> +diferentes "branches" (ramas) con muchos distintos subsistemas espec=C3=
=ADficos
> +a cada una de ellas. Las diferentes ramas son:
> +
> +  - El c=C3=B3digo principal de Linus (mainline tree)
> +  - Varios =C3=A1rboles estables con m=C3=BAltiples major numbers
> +  - Subsistemas espec=C3=ADficos
> +  - linux-next, para integraci=C3=B3n y testing
> +
> +Mainline tree (=C3=81rbol principal)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +El mainline tree es mantenido por Linus Torvalds, y puede encontrarse en
> +https://kernel.org o en su repo.  El proceso de desarrollo es el siguien=
te:
> +
> +  - Tan pronto como se lanza un nuevo kernel, se abre una ventana de dos
> +    semanas, durante este per=C3=ADodo de tiempo, los maintainers pueden=
 enviar
> +    grandes modificaciones a Linus, por lo general los parches que ya se
> +    han incluido en el linux-next durante unas semanas. La forma preferi=
da
> +    de enviar grandes cambios es usando git (la herramienta de
> +    administraci=C3=B3n de codigo fuente del kernel, m=C3=A1s informaci=
=C3=B3n al respecto
> +    en https://git-scm.com/), pero los parches simples tambi=C3=A9n son =
validos.
> +  - Despu=C3=A9s de dos semanas, se lanza un kernel -rc1 y la atenci=C3=
=B3n se centra
> +    en hacer que el kernel nuevo lo m=C3=A1s estable ("solido") posible.=
 La
> +    mayor=C3=ADa de los parches en este punto debe arreglar una regresi=
=C3=B3n. Los
> +    errores que siempre han existido no son regresiones, por lo tanto, s=
olo
> +    env=C3=ADe este tipo de correcciones si son importantes. Tenga en cu=
enta que
> +    se podr=C3=ADa aceptar un controlador (o sistema de archivos) comple=
tamente
> +    nuevo despu=C3=A9s de -rc1 porque no hay riesgo de causar regresione=
s con
> +    tal cambio, siempre y cuando el cambio sea aut=C3=B3nomo y no afecte=
 =C3=A1reas
> +    fuera del c=C3=B3digo que se est=C3=A1 agregando. git se puede usar =
para enviar
> +    parches a Linus despu=C3=A9s de que se lance -rc1, pero los parches =
tambi=C3=A9n
> +    deben ser enviado a una lista de correo p=C3=BAblica para su revisi=
=C3=B3n.
> +  - Se lanza un nuevo -rc cada vez que Linus considera que el =C3=A1rbol=
 git
> +    actual esta en un estado razonablemente sano y adecuado para la prue=
ba.
> +    La meta es lanzar un nuevo kernel -rc cada semana.
> +  - El proceso contin=C3=BAa hasta que el kernel se considera "listo", y=
 esto
> +    puede durar alrededor de 6 semanas.
> +
> +Vale la pena mencionar lo que Andrew Morton escribi=C3=B3 en las listas =
de
> +correo del kernel de Linux, sobre lanzamientos del kernel (traducido):
> +
> +	*"Nadie sabe cu=C3=A1ndo se publicara un nuevo kernel, porque esto suce=
de
> +    de acuerdo con el estado de bugs (error) percibido, no de acuerdo con
> +    una l=C3=ADnea temporal preconcebida."*
> +
> +Varios =C3=A1rboles estables con m=C3=BAltiples major numbers
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Los kernels con versiones de 3 partes son kernels estables. Estos contie=
nen
> +correcciones relativamente peque=C3=B1as y cr=C3=ADticas para problemas =
de seguridad
> +o importantes regresiones descubiertas para una publicaci=C3=B3n de c=C3=
=B3digo.
> +Cada lanzamiento en una gran serie estable incrementa la tercera parte de
> +la versi=C3=B3n n=C3=BAmero, manteniendo las dos primeras partes iguales.
> +
> +Esta es la rama recomendada para los usuarios que quieren la versi=C3=B3n
> +estable m=C3=A1s reciente del kernel, y no est=C3=A1n interesados =E2=80=
=8B=E2=80=8Ben ayudar a probar
> +versiones en desarrollo/experimentales.
> +
> +Los =C3=A1rboles estables son mantenidos por el equipo "estable"
> +<stable@vger.kernel.org>, y se liberan (publican) seg=C3=BAn lo dicten l=
as
> +necesidades. El per=C3=ADodo de liberaci=C3=B3n normal es de aproximadam=
ente dos
> +semanas, pero puede ser m=C3=A1s largo si no hay problemas apremiantes. =
Un
> +problema relacionado con la seguridad, en cambio, puede causar un
> +lanzamiento casi instant=C3=A1neamente.
> +
> +El archivo :ref:`Documentaci=C3=B3n/proceso/stable-kernel-rules.rst <sta=
ble_kernel_rules>`
> +en el =C3=A1rbol del kernel documenta qu=C3=A9 tipos de cambios son acep=
tables para
> +el =C3=A1rbol estable y c=C3=B3mo funciona el proceso de lanzamiento.
> +
> +Subsistemas espec=C3=ADficos
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +Los maintainers de los diversos subsistemas del kernel --- y tambi=C3=A9=
n muchos
> +desarrolladores de subsistemas del kernel --- exponen su estado actual de
> +desarrollo en repositorios fuente. De esta manera, otros pueden ver lo q=
ue
> +est=C3=A1 sucediendo en las diferentes =C3=A1reas del kernel. En =C3=A1r=
eas donde el
> +desarrollo es r=C3=A1pido, se le puede pedir a un desarrollador que base=
 sus
> +env=C3=ADos en tal =C3=A1rbol del subsistema del kernel, para evitar con=
flictos entre
> +este y otros trabajos ya en curso.
> +
> +La mayor=C3=ADa de estos repositorios son =C3=A1rboles git, pero tambi=
=C3=A9n hay otros
> +SCM en uso, o colas de parches que se publican como series quilt. Las
> +direcciones de estos repositorios de subsistemas se enumeran en el archi=
vo
> +MAINTAINERS. Muchos de estos se pueden ver en https://git.kernel.org/.
> +
> +Antes de que un parche propuesto se incluya con dicho =C3=A1rbol de subs=
istemas,
> +es sujeto a revisi=C3=B3n, que ocurre principalmente en las listas de co=
rreo
> +(ver la secci=C3=B3n respectiva a continuaci=C3=B3n). Para varios subsis=
temas del
> +kernel, esta revisi=C3=B3n se rastrea con la herramienta patchwork. Patc=
hwork
> +ofrece una interfaz web que muestra publicaciones de parches, cualquier
> +comentario sobre un parche o revisiones a =C3=A9l, y los maintainers pue=
den
> +marcar los parches como en revisi=C3=B3n, aceptado, o rechazado. La mayo=
r=C3=ADa de
> +estos sitios de trabajo de parches se enumeran en
> +
> +https://patchwork.kernel.org/.
> +
> +linux-next, para integraci=C3=B3n y testing
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Antes de que las actualizaciones de los =C3=A1rboles de subsistemas se c=
ombinen
> +con el =C3=A1rbol principal, necesitan probar su integraci=C3=B3n. Para =
ello, existe
> +un repositorio especial de pruebas en el que se encuentran casi todos los
> +=C3=A1rboles de subsistema, actualizado casi a diario:
> +
> +	https://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git
> +
> +De esta manera, linux-next ofrece una perspectiva resumida de lo que se
> +espera que entre en el kernel principal en el pr=C3=B3ximo per=C3=ADodo =
de "merge"
> +(fusi=C3=B3n de codigo). Los testers aventureros son bienvenidos a probar
> +linux-next en ejecuci=C3=B3n.
> +
> +Reportar bugs
> +-------------
> +
> +El archivo 'Documentaci=C3=B3n/admin-guide/reporting-issues.rst' en el
> +directorio principal del kernel describe c=C3=B3mo informar un posible b=
ug del
> +kernel y detalles sobre qu=C3=A9 tipo de informaci=C3=B3n necesitan los
> +desarrolladores del kernel para ayudar a rastrear la fuente del problema.
> +
> +Gesti=C3=B3n de informes de bugs
> +------------------------------
> +
> +Una de las mejores formas de poner en pr=C3=A1ctica sus habilidades de h=
acking
> +es arreglando errores reportados por otras personas. No solo ayudar=C3=
=A1 a
> +hacer el kernel m=C3=A1s estable, tambi=C3=A9n aprender=C3=A1 a solucion=
ar problemas del
> +mundo real y mejora sus habilidades, y otros desarrolladores se dar=C3=
=A1n
> +cuenta de tu presencia. La correcci=C3=B3n de errores es una de las mejo=
res
> +formas de ganar m=C3=A9ritos entre desarrolladores, porque no a muchas p=
ersonas
> +les gusta perder el tiempo arreglando los errores de otras personas.
> +
> +Para trabajar en informes de errores ya reportados, busque un subsistema
> +que le interese. Verifique el archivo MAINTAINERS donde se informan los
> +errores de ese subsistema; con frecuencia ser=C3=A1 una lista de correo,=
 rara
> +vez un rastreador de errores (bugtracker). Busque en los archivos de dic=
ho
> +lugar para informes recientes y ayude donde lo crea conveniente. Tambi=
=C3=A9n es
> +posible que desee revisar https://bugzilla.kernel.org para informes de
> +errores; solo un pu=C3=B1ado de subsistemas del kernel lo emplean activa=
mente
> +para informar o rastrear; sin embargo, todos los errores para todo el ke=
rnel
> +se archivan all=C3=AD.
> +
> +Listas de correo
> +-----------------
> +
> +Como se explica en algunos de los documentos anteriores, la mayor=C3=ADa=
 de
> +desarrolladores del kernel participan en la lista de correo del kernel de
> +Linux. Detalles sobre c=C3=B3mo para suscribirse y darse de baja de la l=
ista se
> +pueden encontrar en:
> +
> +	http://vger.kernel.org/vger-lists.html#linux-kernel
> +
> +Existen archivos de la lista de correo en la web en muchos lugares
> +distintos. Utilice un motor de b=C3=BAsqueda para encontrar estos archiv=
os. Por
> +ejemplo:
> +
> +	http://dir.gmane.org/gmane.linux.kernel
> +
> +Es muy recomendable que busque en los archivos sobre el tema que desea
> +tratar, antes de publicarlo en la lista. Un mont=C3=B3n de cosas ya disc=
utidas
> +en detalle solo se registran en los archivos de la lista de correo.
> +
> +La mayor=C3=ADa de los subsistemas individuales del kernel tambi=C3=A9n =
tienen sus
> +propias lista de correo donde hacen sus esfuerzos de desarrollo. Revise =
el
> +archivo MAINTAINERS para obtener referencias de lo que estas listas para
> +los diferentes grupos.
> +
> +Muchas de las listas est=C3=A1n alojadas en kernel.org. La informaci=C3=
=B3n sobre
> +estas puede ser encontrada en:
> +
> +	http://vger.kernel.org/vger-lists.html
> +
> +Recuerde mantener buenos h=C3=A1bitos de comportamiento al usar las list=
as.
> +Aunque un poco cursi, la siguiente URL tiene algunas pautas simples para
> +interactuar con la lista (o cualquier lista):
> +
> +	http://www.albion.com/netiquette/
> +
> +Si varias personas responden a su correo, el CC (lista de destinatarios)
> +puede hacerse bastante grande. No elimine a nadie de la lista CC: sin una
> +buena raz=C3=B3n, o no responda solo a la direcci=C3=B3n de la lista. Ac=
ost=C3=BAmbrese
> +a recibir correos dos veces, una del remitente y otra de la lista, y no
> +intente ajustar esto agregando encabezados de correo astutos, a la gente=
 no
> +le gustar=C3=A1.
> +
> +Recuerde mantener intacto el contexto y la atribuci=C3=B3n de sus respue=
stas,
> +mantenga las l=C3=ADneas "El hacker John Kernel escribi=C3=B3 ...:" en l=
a parte
> +superior de su respuesta, y agregue sus declaraciones entre las secciones
> +individuales citadas en lugar de escribiendo en la parte superior del
> +correo electr=C3=B3nico.
> +
> +Si incluye parches en su correo, aseg=C3=BArese de que sean texto legibl=
e sin
> +formato como se indica en :ref:`Documentation/process/submitting-patches=
=2Erst <submittingpatches>`.
> +Los desarrolladores del kernel no quieren lidiar con archivos adjuntos o
> +parches comprimidos; y pueden querer comentar l=C3=ADneas individuales d=
e su
> +parche, que funciona s=C3=B3lo de esa manera. Aseg=C3=BArese de emplear =
un programa
> +de correo que no altere los espacios ni los tabuladores. Una buena prime=
ra
> +prueba es enviarse el correo a usted mismo, e intentar aplicar su
> +propio parche. Si eso no funciona, arregle su programa de correo o
> +reemplace hasta que funcione.
> +
> +Sobretodo, recuerde de ser respetuoso con otros subscriptores.
> +
> +Colaborando con la comunidad
> +----------------------------
> +
> +El objetivo de la comunidad del kernel es proporcionar el mejor kernel
> +posible. Cuando env=C3=ADe un parche para su aceptaci=C3=B3n, se revisar=
=C3=A1 en sus
> +m=C3=A9ritos t=C3=A9cnicos solamente. Entonces, =C2=BFqu=C3=A9 deber=C3=
=ADas ser?
> +
> +  - criticas
> +  - comentarios
> +  - peticiones de cambios
> +  - peticiones de justificaciones
> +  - silencio
> +
> +Recuerde, esto es parte de introducir su parche en el kernel. Tiene que =
ser
> +capaz de recibir cr=C3=ADticas y comentarios sobre sus parches, evaluar
> +a nivel t=C3=A9cnico y re-elaborar sus parches o proporcionar razonamien=
to claro
> +y conciso de por qu=C3=A9 no se deben hacer tales cambios. Si no hay res=
puestas
> +a su publicaci=C3=B3n, espere unos d=C3=ADas e intente de nuevo, a veces=
 las cosas se
> +pierden dado el gran volumen.
> +
> +=C2=BFQu=C3=A9 no deber=C3=ADa hacer?
> +
> +  - esperar ue su parche se acepte sin preguntas
> +  - actuar de forma defensiva
> +  - ignorar comentarios
> +  - enviar el parche de nuevo, sin haber aplicados los cambios pertinent=
es
> +
> +En una comunidad que busca la mejor soluci=C3=B3n t=C3=A9cnica posible, =
siempre habr=C3=A1
> +diferentes opiniones sobre lo beneficioso que es un parche. Tiene que ser
> +cooperativo y estar dispuesto a adaptar su idea para que encaje dentro
> +del kernel, o al menos est=C3=A9 dispuesto a demostrar que su idea vale =
la pena.
> +Recuerea, estar equivocado es aceptable siempre y cuando est=C3=A9s disp=
uesto a
> +trabajar hacia una soluci=C3=B3n que sea correcta.
> +
> +Es normal que las respuestas a su primer parche sean simplemente una lis=
ta
> +de una docena de cosas que debe corregir. Esto **no** implica que su
> +parche no ser=C3=A1 aceptado, y **no** es personal. Simplemente corrija =
todos
> +los problemas planteados en su parche, y envi=C3=A9 otra vez.
> +
> +Diferencias entre la comunidad kernel y las estructuras corporativas
> +--------------------------------------------------------------------
> +
> +La comunidad del kernel funciona de manera diferente a la mayor=C3=ADa d=
e los
> +entornos de desarrollo tradicionales en empresas. Aqu=C3=AD hay una list=
a de
> +cosas que puede intentar hacer para evitar problemas:
> +
> +  Cosas buenas que decir respecto a los cambios propuestos:
> +
> +    - "Esto arregla m=C3=BAltiples problemas."
> +    - "Esto elimina 2000 lineas de c=C3=B3digo."
> +    - "Aqu=C3=AD hay un parche que explica lo que intento describir."
> +    - "Lo he testeado en 5 arquitecturas distintas..."
> +    - "Aqu=C3=AD hay una serie de parches menores que..."
> +    - "Esto mejora el rendimiento en maquinas t=C3=ADpicas..."
> +
> +  Cosas negativas que debe evitar decir:
> +
> +    - "Lo hicimos asi en AIX/ptx/Solaris, de modo que debe ser bueno..."
> +    - "LLevo haciendo esto 20 a=C3=B1os, de modo que..."
> +    - "Esto lo necesita mi empresa para ganar dinero"
> +    - "Esto es para la linea de nuestros productos Enterprise"
> +    - "Aqu=C3=AD esta el documento de 1000 paginas describiendo mi idea"
> +    - "Llevo 6 meses trabajando en esto..."
> +    - "Aqu=C3=AD esta un parche de 5000 lineas que..."
> +    - "He rescrito todo el desastre actual, y aqui esta..."
> +    - "Tengo un deadline, y este parche debe aplicarse ahora."
> +
> +Otra forma en que la comunidad del kernel es diferente a la mayor=C3=ADa=
 de los
> +entornos de trabajo tradicionales en ingenier=C3=ADa de software, es la
> +naturaleza sin rostro de interacci=C3=B3n. Una de las ventajas de utiliz=
ar el
> +correo electr=C3=B3nico y el IRC como formas principales de comunicaci=
=C3=B3n es la
> +no discriminaci=C3=B3n por motivos de g=C3=A9nero o raza. El entorno de =
trabajo del
> +kernel de Linux acepta a mujeres y minor=C3=ADas porque todo lo que eres=
 es una
> +direcci=C3=B3n de correo electr=C3=B3nico. El aspecto internacional tamb=
i=C3=A9n ayuda a
> +nivelar el campo de juego porque no puede adivinar el g=C3=A9nero basado=
 en
> +el nombre de una persona. Un hombre puede llamarse Andrea y una mujer pu=
ede
> +llamarse Pat. La mayor=C3=ADa de las mujeres que han trabajado en el ker=
nel de
> +Linux y han expresado una opini=C3=B3n han tenido experiencias positivas.
> +
> +La barrera del idioma puede causar problemas a algunas personas que no se
> +sientes c=C3=B3modas con el ingl=C3=A9s. Un buen dominio del idioma pued=
e ser
> +necesario para transmitir ideas correctamente en las listas de correo, p=
or
> +lo que le recomendamos que revise sus correos electr=C3=B3nicos para ase=
gurarse
> +de que tengan sentido en ingl=C3=A9s antes de enviarlos.
> +
> +Divida sus cambios
> +---------------------
> +
> +La comunidad del kernel de Linux no acepta con gusto grandes fragmentos =
de
> +c=C3=B3digo, sobretodo a la vez. Los cambios deben introducirse correcta=
mente,
> +discutidos y divididos en peque=C3=B1as porciones individuales. Esto es =
casi
> +exactamente lo contrario de lo que las empresas est=C3=A1n acostumbradas=
 a hacer.
> +Su propuesta tambi=C3=A9n debe introducirse muy temprano en el proceso de
> +desarrollo, de modo que pueda recibir comentarios sobre lo que est=C3=A1
> +haciendo. Tambi=C3=A9n deje que la comunidad sienta que est=C3=A1 trabaj=
ando con
> +ellos, y no simplemente us=C3=A1ndolos como un vertedero para su funci=
=C3=B3n. Sin
> +embargo, no env=C3=ADe 50 correos electr=C3=B3nicos a una vez a una list=
a de correo,
> +su serie de parches debe casi siempre ser m=C3=A1s peque=C3=B1a que eso.
> +
> +Las razones para dividir las cosas son las siguientes:
> +
> +1) Los cambios peque=C3=B1os aumentan la probabilidad de que sus parches=
 sean
> +   aplicados, ya que no requieren mucho tiempo o esfuerzo para verificar=
 su
> +   exactitud. Un parche de 5 l=C3=ADneas puede ser aplicado por un maint=
ainer
> +   con apenas una segunda mirada. Sin embargo, un parche de 500 l=C3=ADn=
eas
> +   puede tardar horas en ser revisado en t=C3=A9rminos de correcci=C3=B3=
n (el tiempo
> +   que toma es exponencialmente proporcional al tama=C3=B1o del parche, =
o algo
> +   as=C3=AD).
> +
> +   Los parches peque=C3=B1os tambi=C3=A9n facilitan la depuraci=C3=B3n c=
uando algo falla.
> +   Es mucho m=C3=A1s f=C3=A1cil retirar los parches uno por uno que dise=
ccionar un
> +   parche muy grande despu=C3=A9s de haber sido aplicado (y roto alguna =
cosa).
> +
> +2) Es importante no solo enviar peque=C3=B1os parches, sino tambi=C3=A9n=
 reescribir
> +   y simplificar (o simplemente reordenar) los parches antes de enviarlo=
s.
> +
> +Esta es una analog=C3=ADa del desarrollador del kernel Al Viro (traducid=
a):
> +
> +	*"Piense en un maestro que califica la tarea de un estudiante de
> +	matem=C3=A1ticas. El maestro no quiere ver los intentos y errores del
> +	estudiante antes de que se les ocurriera la soluci=C3=B3n. Quiere ver la
> +	respuesta m=C3=A1s limpia y elegante. Un buen estudiante lo sabe, y nun=
ca
> +	presentar=C3=ADa su trabajo intermedio antes de tener la soluci=C3=B3n =
final.*
> +
> +	* Lo mismo ocurre con el desarrollo del kernel. Los maintainers y
> +	revisores no quieren ver el proceso de pensamiento detr=C3=A1s de la so=
luci=C3=B3n
> +	al problema que se est=C3=A1 resolviendo. Quieren ver un soluci=C3=B3n =
simple y
> +	elegante."*
> +
> +Puede resultar un reto mantener el equilibrio entre presentar una soluci=
=C3=B3n
> +elegante y trabajar junto a la comunidad, discutiendo su trabajo inacaba=
do.
> +Por lo tanto, es bueno comenzar temprano en el proceso para obtener
> +"feedback" y mejorar su trabajo, pero tambi=C3=A9n mantenga sus cambios =
en
> +peque=C3=B1os trozos que pueden ser aceptados, incluso cuando toda su la=
bor no
> +est=C3=A1 listo para inclusi=C3=B3n en un momento dado.
> +
> +Tambi=C3=A9n tenga en cuenta que no es aceptable enviar parches para su
> +inclusi=C3=B3n que est=C3=A1n sin terminar y ser=C3=A1n "arreglados m=C3=
=A1s tarde".
> +
> +Justifique sus cambios
> +----------------------
> +
> +Adem=C3=A1s de dividir sus parches, es muy importante que deje a la comu=
nidad de
> +Linux sabe por qu=C3=A9 deber=C3=ADan agregar este cambio. Nuevas caract=
er=C3=ADsticas
> +debe justificarse como necesarias y =C3=BAtiles.
> +
> +Documente sus cambios
> +--------------------
> +
> +Cuando env=C3=ADe sus parches, preste especial atenci=C3=B3n a lo que di=
ce en el
> +texto de su correo electr=C3=B3nico. Esta informaci=C3=B3n se convertir=
=C3=A1 en el
> +ChangeLog del parche, y se conservar=C3=A1 para que todos la vean, todo =
el
> +tiempo. Debe describir el parche por completo y contener:
> +
> +  - por que los cambios son necesarios
> +  - el dise=C3=B1o general de su propuesta
> +  - detalles de implementaci=C3=B3n
> +  - resultados de sus experimentos
> +
> +Para obtener m=C3=A1s detalles sobre c=C3=B3mo deber=C3=ADa quedar todo =
esto, consulte la
> +secci=C3=B3n ChangeLog del documento:
> +
> +  "The Perfect Patch"
> +      https://www.ozlabs.org/~akpm/stuff/tpp.txt
> +
> +Todas estas cuestiones son a veces son muy dif=C3=ADciles de conseguir. =
Puede
> +llevar a=C3=B1os perfeccionar estas pr=C3=A1cticas (si es que lo hace). =
Es un proceso
> +continuo de mejora que requiere mucha paciencia y determinaci=C3=B3n. Pe=
ro no se
> +rinda, es posible. Muchos lo han hecho antes, y cada uno tuvo que comenz=
ar
> +exactamente donde est=C3=A1 usted ahora.
> +
> +
> +----------
> +
> +Gracias a Paolo Ciarrocchi que permiti=C3=B3 que la secci=C3=B3n "Develo=
pment Process"
> +se basara en el texto que hab=C3=ADa escrito (https://lwn.net/Articles/9=
4386/),
> +y a Randy Dunlap y Gerrit Huizenga por algunas de la lista de cosas que
> +debes y no debes decir. Tambi=C3=A9n gracias a Pat Mochel, Hanna Linder,=
 Randy
> +Dunlap, Kay Sievers, Vojtech Pavlik, Jan Kara, Josh Boyer, Kees Cook,
> +Andrew Morton, Andi Kleen, Vadim Lobanov, Jesper Juhl, Adrian Bunk,
> +Keri Harris, Frans Pop, David A. Wheeler, Junio =E2=80=8B=E2=80=8BHamano=
, Michael Kerrisk y
> +Alex Shepard por su revisi=C3=B3n, comentarios y contribuciones. Sin su =
ayuda,
> +este documento no hubiera sido posible.
> +
> +Maintainer: Greg Kroah-Hartman <greg@kroah.com>

kernel test robot have already reported documentation warnings at [1],
so I have applied the fixup:

---- >8 ----

diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/tra=
nslations/sp_SP/howto.rst
index 4cf8fa6b9f7c2e..0c072b9a69df30 100644
--- a/Documentation/translations/sp_SP/howto.rst
+++ b/Documentation/translations/sp_SP/howto.rst
@@ -183,7 +183,7 @@ con::
 	make epubdocs
=20
 Convertirse en un/a desarrollador/a de kernel
--------------------------------------------
+---------------------------------------------
=20
 Si no sabe nada sobre el desarrollo del kernel de Linux, deber=C3=ADa cons=
ultar
 el proyecto Linux KernelNewbies:
@@ -274,8 +274,8 @@ Vale la pena mencionar lo que Andrew Morton escribi=C3=
=B3 en las listas de
 correo del kernel de Linux, sobre lanzamientos del kernel (traducido):
=20
 	*"Nadie sabe cu=C3=A1ndo se publicara un nuevo kernel, porque esto sucede
-    de acuerdo con el estado de bugs (error) percibido, no de acuerdo con
-    una l=C3=ADnea temporal preconcebida."*
+        de acuerdo con el estado de bugs (error) percibido, no de acuerdo =
con
+        una l=C3=ADnea temporal preconcebida."*
=20
 Varios =C3=A1rboles estables con m=C3=BAltiples major numbers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -556,7 +556,7 @@ Esta es una analog=C3=ADa del desarrollador del kernel =
Al Viro (traducida):
 	respuesta m=C3=A1s limpia y elegante. Un buen estudiante lo sabe, y nunca
 	presentar=C3=ADa su trabajo intermedio antes de tener la soluci=C3=B3n fi=
nal.*
=20
-	* Lo mismo ocurre con el desarrollo del kernel. Los maintainers y
+	*Lo mismo ocurre con el desarrollo del kernel. Los maintainers y
 	revisores no quieren ver el proceso de pensamiento detr=C3=A1s de la solu=
ci=C3=B3n
 	al problema que se est=C3=A1 resolviendo. Quieren ver un soluci=C3=B3n si=
mple y
 	elegante."*
@@ -579,7 +579,7 @@ Linux sabe por qu=C3=A9 deber=C3=ADan agregar este camb=
io. Nuevas caracter=C3=ADsticas
 debe justificarse como necesarias y =C3=BAtiles.
=20
 Documente sus cambios
---------------------
+---------------------
=20
 Cuando env=C3=ADe sus parches, preste especial atenci=C3=B3n a lo que dice=
 en el
 texto de su correo electr=C3=B3nico. Esta informaci=C3=B3n se convertir=C3=
=A1 en el

Muchas gracias (thanks very much).

[1]: https://lore.kernel.org/linux-doc/202210141348.7UGXRUp8-lkp@intel.com/
--=20
An old man doll... just what I always wanted! - Clara

--c+AzO54Ki4mg0Ky/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0kqFgAKCRD2uYlJVVFO
ozCTAP47LXmKCnian048/t4NvFW0WHBHbiUN2HACephWXIOJGwD+Jj3AkXWGr6jd
TNTyt0KzDlDMAV6SJae3biqsxvIIUQk=
=d1KG
-----END PGP SIGNATURE-----

--c+AzO54Ki4mg0Ky/--
